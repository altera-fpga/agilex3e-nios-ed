| Folder Name | Description |
| ---------- | ----------- |
| Docs | A single document capturing all the details of the example design. |
| img | Block diagram of the example design. |
| ready_to_test | Prebuilt binaries and ISSP scripts for the validated 1000M HTTP server design. Refer to README.md in the sources folder for more information. |
| sources | Raw files and scripts required to recreate/modify the design. |

## Validated 1000M HTTP server flow

This design programs the TSE MAC for 1000M full-duplex operation and serves a
simple HTML page from the FPGA at `10.0.0.2:80`.  The host-side test expects the
link partner interface to use `10.0.0.1/24`.

Run the full clean build and hardware validation from this directory:

```sh
./run_tse_eval_http_full.sh
```

Run only the held-open eval programmer HTTP validation after building:

```sh
./run_tse_eval_http_server.sh
```
