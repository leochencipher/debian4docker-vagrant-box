debian4docker-vagrant-box
=========================

Orignal project from [ffuenf/vagrant-boxes](https://github.com/ffuenf/vagrant-boxes). 

This one aims to build a minimal (but not zero feature and easy to build) docker distribution for the poor people like me who must work with windows as a base system...

Why this box ?
--------------

[debian2docker](https://github.com/unclejack/debian2docker) is a good idea. But very hard to build (in my opinion) especially in windows and for vagrant. In addition, it doesn't provide [virtualbox guest additions](https://www.virtualbox.org/manual/ch04.html) to share with parent host (and it's very complicated to install it : compile etc...).

[boot2docker](https://github.com/boot2docker/boot2docker) is the base system, bot very too much small (iso, hard to customize and provision has its limits to be efficient), with a 32bit user space on a 64bit kernel (lots of bin like fig won't work) and built with [tinycore](http://distro.ibiblio.org/tinycorelinux/) which is good but outdated.

**Provided with :**

* docker 1.3.1
* fig 1.0.1
* make 4.0

Help me if you want
-------------------

I tried to clean a lot of thing in this distrib to make it as small as possible. 

For the moment docker, perl (required by docker) and kernel modules are the biggest things in this distrib.

You can make somme pull request to clean more (like removing other unsed kernel modules : I hadn't the time for the moment) and other small packages (I removed only the bigest for the moment).

In addition any feature or bug fix would be appreciated.

Thanks a lot.

Tools
-----

* [vagrant](http://vagrantup.com)
* [packer](http://packer.io)
* [virtualbox](https://www.virtualbox.org/)
* [babun](http://babun.github.io/)

Usage
-----

You just need to setup a vagrant file like in [debian4docker-vagrant-layout](https://github.com/AlbanMontaigu/debian4docker-vagrant-layout) to use this box with the [vagrant cloud version](https://vagrantcloud.com/AlbanMontaigu/boxes/debian4docker).

Build
-----

**Make sure you have the above tools installed.**

In windows, with **babun** (in linux you can go directly) go in the directory an execute :

```
./box-build.sh
```

Add the box to your vagrant system :

```
./box-add.sh
```

License and Author
------------------

* Author:: Alban Montaigu
* Original Author:: Achim Rosenhagen (a.rosenhagen@ffuenf.de)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
