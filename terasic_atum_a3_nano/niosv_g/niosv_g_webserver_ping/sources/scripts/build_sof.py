# (C) 2001-2024 Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License Subscription 
# Agreement, Intel FPGA IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Intel and sold by 
# Intel or its authorized distributors.  Please refer to the applicable 
# agreement for further details.
 
 
# (C) 2001-2024 Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License Subscription 
# Agreement, Intel FPGA IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Intel and sold by 
# Intel or its authorized distributors.  Please refer to the applicable 
# agreement for further details.
 
 
#
##################################################################################
# Python code to generate the .sof file from qsys and qpf tcl files
 
# Requirements to successfully run this script:
# Python version >= 3.5
# Quartus environment
 
#author: Altera
#version: 14 SEPT 2025
####################################################################################
# import libraries
import subprocess
import sys
import os, glob, re
 
# define directories
cwd_1 = "./hw"
cwd_2 = "./scripts"
 
# Find project name & qpf, qsys tcl directories
os.chdir(cwd_2)
cntr=0
qpf_name = ''
qsys_tcl = ''
qpf_tcl = ''
qpf_tcl_dir = ''
qsys_tcl_dir = ''

# Prefer canonical script names when available.
script_files = sorted(glob.glob("*.tcl*"))
if "top.tcl" in script_files:
    qpf_tcl = "top.tcl"
    qpf_tcl_dir = "../scripts/" + qpf_tcl
if "design_export.tcl" in script_files:
    qsys_tcl = "design_export.tcl"
    qsys_tcl_dir = "../scripts/" + qsys_tcl

for file in script_files:
    if ".gz" in file:
        gz_unzip = subprocess.Popen("gzip -d {}".format(file),shell=True)
        gz_unzip.wait()
        sep_qproj = '.gz'
        file = file.split(sep_qproj,1)[0]
    with open (file,'r') as f1:
        line_f1 = f1.readlines()
        for i,line in enumerate(line_f1):
            if 'project_exists ' in line:
                if not qpf_tcl:
                    qpf_tcl = file
                    qpf_tcl_dir = "../scripts/" + qpf_tcl
                qpf_name = line_f1[i].replace(" ","").split("project_exists",1)[1]
                qpf_name = re.sub(r"[{}]",'',qpf_name).replace(']','').rstrip()
            elif 'project_new -overwrite' in line:
                if not qpf_tcl:
                    qpf_tcl = file
                    qpf_tcl_dir = "../scripts/" + qpf_tcl
                qpf_name = line_f1[i].replace(" ","").split("project_new-overwrite",1)[1].rstrip()             
            elif ('create_system ' in line) or ('set sys_name ' in line):
                if not qsys_tcl:
                    qsys_tcl = file
                    qsys_tcl_dir = "../scripts/" + qsys_tcl
                #qsys_name = line_f1[i].replace(" ","").split("create_system",1)[1]
 
qpf_dir = qpf_name +".qpf"
 
# print(qpf_name)
# print(qpf_dir)
# print(qsys_tcl_dir)
os.chdir("../")
 
logfile = open('logfile.txt', 'wb')
 
# Generate qpf file
 
generate_qpf = subprocess.Popen(["quartus_sh","-t",str(qpf_tcl_dir)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
for line in generate_qpf.stdout:
    logfile.write(line)
generate_qpf.wait()
 
# Open a project
# quartus_sh --flow compile <project_name>
# open_qpf = subprocess.Popen(["quartus_sh","--flow","compile",str(qpf_name)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
# for line in open_qpf.stdout:
#     logfile.write(line)
# open_qpf.wait()
 
# Generate the VDS child IP descriptors from the tracked Platform Designer script.
vds_ip_generator = os.path.join(cwd_2, "generate_vds_ip.sh")
if os.path.exists(vds_ip_generator):
    generate_vds_ip = subprocess.Popen([vds_ip_generator], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in generate_vds_ip.stdout:
        logfile.write(line)
    generate_vds_ip.wait()
    if generate_vds_ip.returncode != 0:
        logfile.close()
        sys.exit(generate_vds_ip.returncode)
elif qsys_tcl_dir != '':
    generate_qsys = subprocess.Popen(["quartus_sh","-t",str(qsys_tcl_dir)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
    for line in generate_qsys.stdout:
        logfile.write(line)
    generate_qsys.wait()
else:
    logfile.write(b"WARNING: No VDS child IP generator found. Continuing with existing generated files.\n")
 
# # Generate qsys file
# generate_qsys = subprocess.Popen(["qsys-script","--script={}".format(qsys_tcl_dir),"--quartus-project={}".format(qpf_dir)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
# for line in generate_qsys.stdout:
#     logfile.write(line)
# generate_qsys.wait()
 
# Generate ip
generate_ip = subprocess.Popen(["quartus_ipgenerate","{}".format(qpf_dir)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
for line in generate_ip.stdout:
    logfile.write(line)
generate_ip.wait()
 
# quartus_sh --flow compile ${design_top}.qpf
 
# Generate hex file only if helper script is available.
niosv_app_script = "scripts/niosv_app_creation.sh"
if os.path.exists(niosv_app_script):
    app_creation = subprocess.Popen(["niosv-shell < {}".format(niosv_app_script)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,shell= True)
    for line in app_creation.stdout:
        logfile.write(line)
    app_creation.wait()
else:
    logfile.write(b"WARNING: scripts/niosv_app_creation.sh not found. Skipping niosv-shell step.\n")
 
 
# # Compile Flow
# compile_flow = subprocess.Popen(["quartus_sh", "--flow", "compile","{}".format(qpf_dir)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
# for line in compile_flow.stdout:
#     logfile.write(line)
# compile_flow.wait()
 
# Synthesis
quartus_sync = subprocess.Popen(["quartus_syn","{}".format(qpf_dir)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
for line in quartus_sync.stdout:
    logfile.write(line)
quartus_sync.wait()
 
# Fitting
quartus_fit = subprocess.Popen(["quartus_fit","{}".format(qpf_dir)],stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
for line in quartus_fit.stdout:
    logfile.write(line)
quartus_fit.wait()
 
# Timing analysis
quartus_sta = subprocess.Popen(["quartus_sta","{}".format(qpf_name),"-c","{}".format(qpf_name), "--mode=finalize"],stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
for line in quartus_sta.stdout:
    logfile.write(line)
quartus_sta.wait()
 
# Assembly
quartus_asm = subprocess.Popen(["quartus_asm","{}".format(qpf_dir)],stdout=subprocess.PIPE, stderr=subprocess.STDOUT,cwd=cwd_1)
for line in quartus_asm.stdout:
    logfile.write(line)
quartus_asm.wait()
