/*
 * License Agreement
 *
 * Copyright (c) 2025
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <io.h>
#include <stdbool.h>
#include <fcntl.h>
#include <sys/termios.h>
#include "sys/ioctl.h"
#include "sys/alt_log_printf.h"
#include "system.h"
#include "altera_avalon_jtag_uart_regs.h"
#include "altera_avalon_jtag_uart.h"
#include "altera_msgdma_csr_regs.h"
 
#include "task.h" 
#include "timers.h" 
#include "FreeRTOS.h"
#include "FreeRTOS_IP.h"
#include "FreeRTOS_Sockets.h"
#include "FreeRTOS_TCP_IP.h"
#include "FreeRTOS_IP.h"
#include "FreeRTOSIPConfig.h"
#include "FreeRTOS_Routing.h"
#include "NetworkInterface.h"
#include "tse_driver.h"
#include "colorbar_image.h"
#include "desktop_background_image.h"
 
#define PING_TASK_STACKSIZE 4096
#define PING_TASK_PRIORITY  (configMAX_PRIORITIES - 3)
#define UDP_TASK_STACKSIZE  4096
#define UDP_TASK_PRIORITY   (configMAX_PRIORITIES - 3)
#define UDP_LOOPBACK_PORT   5002u
#define UDP_LOOPBACK_BUFFER_BYTES 512u
#define HTTP_TASK_STACKSIZE 4096
#define HTTP_TASK_PRIORITY  (configMAX_PRIORITIES - 3)
#define HTTP_SERVER_PORT    80u
#define HTTP_REQUEST_BUFFER_BYTES 256u
 
static TaskHandle_t xPingTaskHandle = NULL;
static TaskHandle_t xUdpTaskHandle = NULL;
static TaskHandle_t xHttpTaskHandle = NULL;

#define NET_PROOF_ATTR __attribute__((used, section(".net_proof_status")))
volatile uint32_t net_proof_magic NET_PROOF_ATTR = 0x4e455450u; /* NETP */
volatile uint32_t net_proof_network_up NET_PROOF_ATTR = 0u;
volatile uint32_t net_proof_ping_replies NET_PROOF_ATTR = 0u;
volatile uint32_t net_proof_udp_sent NET_PROOF_ATTR = 0u;
volatile uint32_t net_proof_udp_received NET_PROOF_ATTR = 0u;
volatile uint32_t net_proof_udp_echoed NET_PROOF_ATTR = 0u;
volatile uint32_t net_proof_udp_last_len NET_PROOF_ATTR = 0u;
volatile uint32_t net_proof_udp_last_from NET_PROOF_ATTR = 0u;
volatile uint32_t net_proof_udp_last_send_result NET_PROOF_ATTR = 0u;

static const char cHttpBody[] =
    "<!doctype html>\n"
    "<html><head><meta charset=\"utf-8\"><title>Atum A3 Nano</title></head>\n"
    "<body style=\"font-family:sans-serif;margin:24px;background:#0b1720;color:white\">\n"
    "<h1>Atum A3 Nano</h1><p>FreeRTOS + TSE is serving HTML with inline images.</p>\n"
    "<div style=\"width:640px;max-width:100%;padding:8px;background:#fff;border-radius:6px\">\n"
    "<img src=\"" COLORBAR_SVG_DATA_URI "\" alt=\"Color bars\" style=\"display:block;width:100%;height:auto;margin-bottom:8px\">\n"
    "<img src=\"" DESKTOP_BACKGROUND_JPG_DATA_URI "\" alt=\"Desktop background\" style=\"display:block;width:100%;height:auto\">\n"
    "</div>\n"
    "<p style=\"font-size:13px;color:#b8ccd8\">Images: generated color bars and ag3-wallpaper.png</p></body></html>\n";
 
/* Called if a task overflows its stack */
void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName)
{
    printf("STACK OVERFLOW in task %s\n", pcTaskName);
    taskDISABLE_INTERRUPTS();
    for( ;; );
}

/* Called if malloc fails */
void vApplicationMallocFailedHook(void)
{
    printf("MALLOC FAILED\n");
    taskDISABLE_INTERRUPTS();
    for( ;; );
}

void generate_random_mac(uint8_t * mac_address)
{
    // Set the locally administered bit (0x02 in the first octet)
    mac_address[0] = 0x02; 
 
    // Generate random bytes for the remaining 5 octets
    for ( int i = 1; i < 6; i++ )
    {
        mac_address[i] = (uint8_t)rand();
    }
}
 
void vPingTestTask(void *pvParameters)
{
    const uint8_t ucIPAddressToPing[4] = { 10, 0, 0, 1 };
    uint32_t ucIPAddress;
 
    if(!FreeRTOS_inet_pton(FREERTOS_AF_INET, "10.0.0.1", &ucIPAddress))
        printf("IP address conversion failure\n");
 
    const TickType_t xDelayBetweenPings = pdMS_TO_TICKS(1000);
 
    xPingTaskHandle = xTaskGetCurrentTaskHandle();
    ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
    printf("MSGDMA CSR read 1 0x%08X\n:", IORD_ALTERA_MSGDMA_CSR_STATUS(SYS_TSE_MSGDMA_TX_CSR_BASE));

    for (;;)
    {
        BaseType_t xResult = FreeRTOS_SendPingRequest(ucIPAddress,
                                                      64,          // Ping data size
                                                      1000000);    // Timeout in ms
 
        if (xResult != pdFAIL)
        {
            printf("[PING] Request Sent: %u.%u.%u.%u Identifier %lu\n",
                   ucIPAddressToPing[0], ucIPAddressToPing[1],
                   ucIPAddressToPing[2], ucIPAddressToPing[3], xResult);
                   //dumpMACStats();
                   //printf ("LED config register value is 0x%08X\n", read_phy_register (TSE_MAC_BASE_ADDRESS, 0x0018));
        }
        else
        {
            printf("[PING] Request Failed: %u.%u.%u.%u\n",
                   ucIPAddressToPing[0], ucIPAddressToPing[1],
                   ucIPAddressToPing[2], ucIPAddressToPing[3]);
        }
        vTaskDelay(xDelayBetweenPings);
        //printf ("send ping request function\n");
    }
}

void vUdpLoopbackTask(void *pvParameters)
{
    Socket_t xSocket;
    struct freertos_sockaddr xBindAddress;
    struct freertos_sockaddr xSourceAddress;
    socklen_t xSourceAddressLength;
    const TickType_t xReceiveTimeout = pdMS_TO_TICKS(1000u);
    const TickType_t xSendTimeout = pdMS_TO_TICKS(1000u);
    char cRxBuffer[UDP_LOOPBACK_BUFFER_BYTES];

    (void)pvParameters;
    xUdpTaskHandle = xTaskGetCurrentTaskHandle();
    ulTaskNotifyTake(pdTRUE, portMAX_DELAY);

    xSocket = FreeRTOS_socket(FREERTOS_AF_INET, FREERTOS_SOCK_DGRAM, FREERTOS_IPPROTO_UDP);
    if (xSocket == FREERTOS_INVALID_SOCKET) {
        printf("[UDP] socket create failed\n");
        vTaskDelete(NULL);
    }

    memset(&xBindAddress, 0, sizeof(xBindAddress));
    xBindAddress.sin_len = sizeof(xBindAddress);
    xBindAddress.sin_family = FREERTOS_AF_INET;
    xBindAddress.sin_port = FreeRTOS_htons(UDP_LOOPBACK_PORT);
    xBindAddress.sin_addr = 0;

    if (FreeRTOS_bind(xSocket, &xBindAddress, sizeof(xBindAddress)) != 0) {
        printf("[UDP] bind failed on port %u\n", UDP_LOOPBACK_PORT);
        FreeRTOS_closesocket(xSocket);
        vTaskDelete(NULL);
    }

    FreeRTOS_setsockopt(xSocket, 0, FREERTOS_SO_RCVTIMEO, &xReceiveTimeout, sizeof(xReceiveTimeout));
    FreeRTOS_setsockopt(xSocket, 0, FREERTOS_SO_SNDTIMEO, &xSendTimeout, sizeof(xSendTimeout));

    printf("[UDP] loopback task bound on FPGA port %u\n", UDP_LOOPBACK_PORT);

    for (;;) {
        int32_t lBytesReceived;

        xSourceAddressLength = sizeof(xSourceAddress);
        memset(&xSourceAddress, 0, sizeof(xSourceAddress));
        lBytesReceived = FreeRTOS_recvfrom(xSocket,
                                           cRxBuffer,
                                           sizeof(cRxBuffer),
                                           0,
                                           &xSourceAddress,
                                           &xSourceAddressLength);

        if (lBytesReceived > 0) {
            int32_t lEchoed;
            net_proof_udp_received++;
            net_proof_udp_last_len = (uint32_t)lBytesReceived;
            net_proof_udp_last_from = xSourceAddress.sin_addr;

            xSourceAddress.sin_len = sizeof(xSourceAddress);
            xSourceAddress.sin_family = FREERTOS_AF_INET;
            lEchoed = FreeRTOS_sendto(xSocket,
                                      cRxBuffer,
                                      (size_t)lBytesReceived,
                                      0,
                                      &xSourceAddress,
                                      xSourceAddressLength);
            net_proof_udp_last_send_result = (uint32_t)lEchoed;
            if (lEchoed > 0) {
                net_proof_udp_sent++;
                net_proof_udp_echoed++;
            }

            printf("[UDP] loopback rx %ld bytes from 0x%08lX:%u, echo result %ld\n",
                   (long)lBytesReceived,
                   (unsigned long)xSourceAddress.sin_addr,
                   FreeRTOS_ntohs(xSourceAddress.sin_port),
                   (long)lEchoed);
        }
    }
}

static BaseType_t prvHttpSendAll(Socket_t xSocket, const char *pcBuffer, size_t uxLength)
{
    size_t uxSentTotal = 0u;

    while (uxSentTotal < uxLength) {
        BaseType_t xSent = FreeRTOS_send(xSocket,
                                         pcBuffer + uxSentTotal,
                                         uxLength - uxSentTotal,
                                         0);
        if (xSent <= 0) {
            return xSent;
        }
        uxSentTotal += (size_t)xSent;
    }

    return (BaseType_t)uxSentTotal;
}

void vHttpServerTask(void *pvParameters)
{
    Socket_t xListenSocket;
    struct freertos_sockaddr xBindAddress;
    const TickType_t xReceiveTimeout = pdMS_TO_TICKS(3000u);
    const TickType_t xSendTimeout = pdMS_TO_TICKS(3000u);

    (void)pvParameters;
    xHttpTaskHandle = xTaskGetCurrentTaskHandle();
    ulTaskNotifyTake(pdTRUE, portMAX_DELAY);

    xListenSocket = FreeRTOS_socket(FREERTOS_AF_INET, FREERTOS_SOCK_STREAM, FREERTOS_IPPROTO_TCP);
    if (xListenSocket == FREERTOS_INVALID_SOCKET) {
        printf("[HTTP] listen socket create failed\n");
        vTaskDelete(NULL);
    }

    FreeRTOS_setsockopt(xListenSocket, 0, FREERTOS_SO_SNDTIMEO, &xSendTimeout, sizeof(xSendTimeout));

    memset(&xBindAddress, 0, sizeof(xBindAddress));
    xBindAddress.sin_len = sizeof(xBindAddress);
    xBindAddress.sin_family = FREERTOS_AF_INET;
    xBindAddress.sin_port = FreeRTOS_htons(HTTP_SERVER_PORT);
    xBindAddress.sin_addr = 0;

    if (FreeRTOS_bind(xListenSocket, &xBindAddress, sizeof(xBindAddress)) != 0) {
        printf("[HTTP] bind failed on port %u\n", HTTP_SERVER_PORT);
        FreeRTOS_closesocket(xListenSocket);
        vTaskDelete(NULL);
    }

    if (FreeRTOS_listen(xListenSocket, 2) != 0) {
        printf("[HTTP] listen failed on port %u\n", HTTP_SERVER_PORT);
        FreeRTOS_closesocket(xListenSocket);
        vTaskDelete(NULL);
    }

    printf("[HTTP] serving simple HTML on FPGA port %u\n", HTTP_SERVER_PORT);

    for (;;) {
        Socket_t xClientSocket;
        struct freertos_sockaddr xClientAddress;
        socklen_t xClientAddressLength = sizeof(xClientAddress);

        memset(&xClientAddress, 0, sizeof(xClientAddress));
        xClientSocket = FreeRTOS_accept(xListenSocket, &xClientAddress, &xClientAddressLength);
        if ((xClientSocket == FREERTOS_INVALID_SOCKET) || (xClientSocket == NULL)) {
            continue;
        }

        FreeRTOS_setsockopt(xClientSocket, 0, FREERTOS_SO_RCVTIMEO, &xReceiveTimeout, sizeof(xReceiveTimeout));
        FreeRTOS_setsockopt(xClientSocket, 0, FREERTOS_SO_SNDTIMEO, &xSendTimeout, sizeof(xSendTimeout));

        char cRequestBuffer[HTTP_REQUEST_BUFFER_BYTES];
        BaseType_t xReceived = FreeRTOS_recv(xClientSocket,
                                             cRequestBuffer,
                                             sizeof(cRequestBuffer) - 1u,
                                             0);
        if (xReceived > 0) {
            cRequestBuffer[xReceived] = '\0';
        }

        const char *pcContentType = "text/html; charset=utf-8";
        const char *pcPayload = cHttpBody;
        size_t uxPayloadLength = sizeof(cHttpBody) - 1u;
        const char *pcRoute = "/";
        if ((xReceived > 0) && (strncmp(cRequestBuffer, "GET /bg.jpg", 11u) == 0)) {
            pcContentType = "image/jpeg";
            pcPayload = (const char *)gDesktopBackgroundJpg;
            uxPayloadLength = (size_t)gDesktopBackgroundJpgLen;
            pcRoute = "/bg.jpg";
        }

        char cHeader[192];
        int lHeaderLength = snprintf(cHeader,
                                     sizeof(cHeader),
                                     "HTTP/1.1 200 OK\r\n"
                                     "Content-Type: %s\r\n"
                                     "Content-Length: %u\r\n"
                                     "Connection: close\r\n"
                                     "Cache-Control: no-store\r\n"
                                     "\r\n",
                                     pcContentType,
                                     (unsigned)uxPayloadLength);
        BaseType_t xHeaderSent = -1;
        BaseType_t xBodySent = -1;
        if ((lHeaderLength > 0) && ((size_t)lHeaderLength < sizeof(cHeader))) {
            xHeaderSent = prvHttpSendAll(xClientSocket, cHeader, (size_t)lHeaderLength);
            if (xHeaderSent == lHeaderLength) {
                xBodySent = prvHttpSendAll(xClientSocket, pcPayload, uxPayloadLength);
            }
        }
        printf("[HTTP] request %s from 0x%08lX:%u rx %ld header %ld body %ld\n",
               pcRoute,
               (unsigned long)xClientAddress.sin_addr,
               FreeRTOS_ntohs(xClientAddress.sin_port),
               (long)xReceived,
               (long)xHeaderSent,
               (long)xBodySent);

        if (xBodySent > 0) {
            vTaskDelay(pdMS_TO_TICKS(1000u));
        }
        FreeRTOS_shutdown(xClientSocket, FREERTOS_SHUT_RDWR);
        vTaskDelay(pdMS_TO_TICKS(250u));
        FreeRTOS_closesocket(xClientSocket);
    }
}
 
BaseType_t xApplicationGetRandomNumber( uint32_t *pulNumber )
{
    *pulNumber = ( uint32_t ) rand();
    return pdTRUE;
}
 
uint32_t ulApplicationGetNextSequenceNumber(
    uint32_t ulSourceAddress,
    uint16_t usSourcePort,
    uint32_t ulDestinationAddress,
    uint16_t usDestinationPort)
{
    return ( uint32_t ) rand();
}
 
const char *pcApplicationHostnameHook(void)
{
    return "MyFreeRTOSDevice";
}
 
BaseType_t xApplicationDNSQueryHook(const char *pcName)
{
    if (strcasecmp(pcName, pcApplicationHostnameHook()) == 0)
    {
        return pdPASS;
    }
 
    return pdFAIL;
}
 
void vApplicationPingReplyHook(ePingReplyStatus_t eStatus, uint16_t usIdentifier) {
    switch (eStatus) {
        case eSuccess:
            net_proof_ping_replies++;
            printf("[Ping] Reply received: Identifier %u\n", usIdentifier);
            //vPrintEthernetStats();
            break;
        case eInvalidChecksum:
            printf("[Ping] Reply received with invalid checksum: Identifier %u\n", usIdentifier);
            break;
        case eInvalidData:
            printf("[Ping] reply received with invalid data: Identifier %u\n", usIdentifier);
            break;
        default:
            printf("[Ping] Unknown ping reply status: Identifier %u\n", usIdentifier);
            break;
    }
}
 
void vApplicationIPNetworkEventHook( eIPCallbackEvent_t eNetworkEvent )
{
    char cBuffer[ 16 ];  
 
    if (eNetworkEvent == eNetworkUp)
    {
        FreeRTOS_printf(("Network is UP!\n"));
        net_proof_network_up++;
 
        uint32_t ulIPAddress, ulNetMask, ulGatewayAddress, ulDNSServerAddress;  
        FreeRTOS_GetAddressConfiguration(
            &ulIPAddress,
            &ulNetMask,
            &ulGatewayAddress,
            &ulDNSServerAddress
        );
 
        FreeRTOS_inet_ntoa( ulIPAddress, cBuffer );  
        printf( "IP Address: %s\n", cBuffer );  
  
        /* Convert the net mask to a string then print it out. */  
        FreeRTOS_inet_ntoa( ulNetMask, cBuffer );  
        printf( "Subnet Mask: %s\n", cBuffer );  
  
        /* Convert the IP address of the gateway to a string then print it out. */  
        FreeRTOS_inet_ntoa( ulGatewayAddress, cBuffer );  
        printf( "Gateway IP Address: %s\n", cBuffer );  
  
        /* Convert the IP address of the DNS server to a string then print it out. */  
        FreeRTOS_inet_ntoa( ulDNSServerAddress, cBuffer );  
        printf( "DNS server IP Address: %s\n", cBuffer ); 
    }
    if (xPingTaskHandle != NULL) {
        xTaskNotifyGive(xPingTaskHandle);
    }
    if (xUdpTaskHandle != NULL) {
        xTaskNotifyGive(xUdpTaskHandle);
    }
    if (xHttpTaskHandle != NULL) {
        xTaskNotifyGive(xHttpTaskHandle);
    }
}
 
BaseType_t vInitialiseNetworkInterface()
{
    const uint8_t ucIPAddress[ 4 ]  = { 10, 0, 0, 2};
    const uint8_t ucNetMask[ 4 ]    = { 255, 255, 255, 0 };
    const uint8_t ucGateway[ 4 ]    = { 10, 0, 0, 2 };
    const uint8_t ucDNSServer[ 4 ]  = { 0, 0, 0, 0 };
    uint8_t ucMACAddress[ 6 ];

    generate_random_mac(ucMACAddress);
 

	BaseType_t ret = FreeRTOS_IPInit(
        ucIPAddress,
        ucNetMask,
        ucGateway,
        ucDNSServer,
        ucMACAddress
    );
    return ret;
}
 
int main(void)
{
	printf("Hello FreeRTOS from main...\n");
 
    if(!vInitialiseNetworkInterface()) {
        printf("Network initialization failure. System Halted\n");
        while(1);
    }
 
    if (pdFAIL == xTaskCreate( vPingTestTask, "vPingTestTask", PING_TASK_STACKSIZE, NULL, PING_TASK_PRIORITY, &xPingTaskHandle)){
		printf("Ping Task creation fail!!!!\n");
	}
    if (pdFAIL == xTaskCreate( vUdpLoopbackTask, "vUdpLoopbackTask", UDP_TASK_STACKSIZE, NULL, UDP_TASK_PRIORITY, &xUdpTaskHandle)){
		printf("UDP Task creation fail!!!!\n");
	}
    if (pdFAIL == xTaskCreate( vHttpServerTask, "vHttpServerTask", HTTP_TASK_STACKSIZE, NULL, HTTP_TASK_PRIORITY, &xHttpTaskHandle)){
		printf("HTTP Task creation fail!!!!\n");
	}
	vTaskStartScheduler();
 
	for( ;; );
}
