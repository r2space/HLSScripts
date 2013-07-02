## HLSScripts (CentOS6 64bit) 的部署过程
==========

#### 添加关联软件的yum源：RPMForge和Fedora
    # rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.i686.rpm
    # rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

#### 为了能够对应x264, Xvid，安装yasm
    # yum -y install yasm

#### 安装转码工具ffmpeg
    # yum -y install ffmpeg ffmpeg-devel

#### 为了分割并生成m3u8，编译segmenter
    # 代码可从 http://svn.assembla.com/svn/legend/segmenter/ 下载

    # 安装编译器
    # yum install make
    # yum install gcc

    # cd segmenter-src
    # make

#### 整个转码的过程如下
* ffmpeg转码，生成ts文件
* 分割并生成m3u8文件
* segmenter的命令行参数如下

#### 根据需要web服务器可能需要设定mime
    # vi /etc/nginx/mime.types
      application/x-mpegURL         m3u8;
      video/MP2T                    ts;
      
#### 测试用html如下
    <html>
      <head>
      <title>Movie</title>
      <meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
      </head>
      <body style="background-color:#FFFFFF; ">
        <center>
          <video src="movie/sample.m3u8" controls autoplay ></video>
        </center>
      </body>
    </html>
#### 对应的目录结构如下
    ├── index.html
    ├── movie
    │   ├── sample-1.ts
    │   ├── sample-2.ts
    │   ├── sample-3.ts
    │   ├── sample.m3u8
    │   ├── convert.sh
    │   ├── sample.mov
    │   └── segmenter

