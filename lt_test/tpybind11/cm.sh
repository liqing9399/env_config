#######s############################################
#filename      : cm.sh
#author        : litao
#e-mail        : Tao.Li@streamcomputing.com
#create time   : 2023-05-24 10:49:09
#last modified : 2023-05-24 10:49:09
####################################################
#!/bin/bash
g++ -O0 -g -Wall -shared -std=c++11 -fPIC $(python3 -m pybind11 --includes) example.cpp -o emp$(python3-config --extension-suffix)
