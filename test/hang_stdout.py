import os
import subprocess
import shlex
import datetime

print("Start:" + datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))

p = subprocess.Popen("./tini -s -g -p SIGKILL -- ./test/stdout_press.sh", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
p.wait()

print("Exit:" + datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
