#!/usr/bin/python3
import yaml
import os

ca_certs_folder = f"/app/volume_dir/ca"
ia_certs_folder = f"/app/volume_dir/ia"
pfx_certs_folder = f"/app/volume_dir/pfx"
pfx_names_with_passwords = []
with open(f"{pfx_certs_folder}/passwords.yaml", "r") as read_file:
    pfx_names_with_passwords = yaml.safe_load(read_file)

ca_certs_names = list(
    filter(lambda x: os.path.isfile(os.path.join(ca_certs_folder, x)), os.listdir(ca_certs_folder)))
for ca_cert in ca_certs_names:
    cmd = f"yes o | certmgr -inst -all -file {ca_certs_folder}/{ca_cert} -store uRoot"
    os.system(cmd)

ia_certs_names = list(
    filter(lambda x: os.path.isfile(os.path.join(ia_certs_folder, x)), os.listdir(ia_certs_folder)))
for ia_cert in ia_certs_names:
    cmd = f"certmgr -inst -file {ia_certs_folder}/{ia_cert} -store uCa"
    os.system(cmd)

for pfx_file, password in pfx_names_with_passwords.items():
    cmd = f"certmgr -inst -file {pfx_certs_folder}/{pfx_file} -pfx -store uMy -silent -keep_exportable -pin {password}"
    os.system(cmd)
