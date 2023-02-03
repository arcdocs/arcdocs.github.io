# FFmpeg

FFmpeg is the leading multimedia framework, able to decode, encode, transcode, mux, demux, stream, filter and play pretty much anything that humans and machines have created. It supports the most obscure ancient formats up to the cutting edge. No matter if they were designed by some standards committee, the community or a corporation. It is also highly portable: FFmpeg compiles, runs, and passes our testing infrastructure FATE across Linux, Mac OS X, Microsoft Windows, the BSDs, Solaris, etc. under a wide variety of build environments, machine architectures, and configurations.



Read more about FFmpeg on their [website](http://www.ffmpeg.org/).





## Licensing

FFmpeg is licensed under the GNU Lesser General Public License (LGPL) version 2.1 or later. However, FFmpeg incorporates several optional parts and optimizations that are covered by the GNU General Public License (GPL) version 2 or later. If those parts get used the GPL applies to all of FFmpeg.



## The FFmpeg module on the HPC

The FFmpeg module can be loaded into your environment with the following command:

```bash
$ module add ffmpeg
```

The FFmpeg module is available on ARC3 and ARC4:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC4
  - FFmpeg 4.0
  - `module add ffmpeg/4.0`

* - ARC3
  - FFmpeg 4.0
  - `module add ffmpeg/4.0`

* - ARC3
  - FFmpeg 3.4
  - `module add ffmpeg/3.4`

* - ARC3
  - FFmpeg 3.2.1
  - `module add ffmpeg/3.2.1`

```
