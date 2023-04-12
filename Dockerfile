#生成的新镜像以centos镜像为基础
FROM     fs185085781/webos:latest
MAINTAINER a79520,MTkej <1179697713@qq.com>

#开放窗口的8088端口
EXPOSE 8088

#运行脚本
CMD ["sh" "restart.sh"]
