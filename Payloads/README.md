## lottapixel

Originally reported at https://hackerone.com/reports/390, addressed on paperclip.

A specially crafted JPEG (the original file was named lottapixel.jpg) causes attempts to determine the dimensions of the image to exhaust available memory. From the original report:

The exploit is really simple. I have an image of 5kb, 260x260 pixels. In the image itself I exchange the 260x260 values with 0xfafa x 0xfafa (so 64250x64250 pixels). Now from what I remember your service tries to convert the image once uploaded. By loading the 'whole image' into memory, it tries to allocate 4128062500 pixels into memory, flooding the memory and causing DoS.

## uber.gif

Current limits

Image size: 1 MB
Image dimensions: 2048x2048px
File types: jpg/png/gif

Another image hack

A GIF composed of 40k 1x1 images made Paperclip freeze until timeout.

As attachments I sent the file composed of 40k images, and a screenshot of the timeout.

## EICAR File

The EICAR Standard Anti-Virus Test File or EICAR test file is a computer file that was developed by the European Institute for Computer Antivirus Research (EICAR) and Computer Antivirus Research Organization (CARO), to test the response of computer antivirus (AV) programs. Instead of using real malware, which could do real damage, this test file allows people to test anti-virus software without having to use a real computer virus.

Anti-virus programmers set the EICAR string as a verified virus, similar to other identified signatures. A compliant virus scanner, when detecting the file, will respond in exactly the same manner as if it found a harmful virus. Not all virus scanners are compliant, and may not detect the file even when they are correctly configured.

The use of the EICAR test string can be more versatile than straightforward detection: a file containing the EICAR test string can be compressed or archived, and then the antivirus software can be run to see whether it can detect the test string in the compressed file.

## xssproject File

As you may already know, it is possible to make a website vulnerable to XSS if you can upload/include a SWF file into that website. I am going to represent this SWF file that you can use in your PoCs.

This method is based on [1] and [2], and it has been tested in Google Chrome, Mozilla Firefox, IE9/8; there should not be any problem with other browsers either.

Examples:

Browsers other than IE: http://0me.me/demo/xss/xssproject.swf?js=alert(document.domain);

IE8: http://0me.me/demo/xss/xssproject.swf?js=try{alert(document.domain)}catch(e){ window.open(‘?js=history.go(-1)’,’_self’);}

IE9: http://0me.me/demo/xss/xssproject.swf?js=w=window.open(‘invalidfileinvalidfileinvalidfile’,’target’);setTimeout(‘alert(w.document.location);w.close();’,1);

## POC_img_phpinfo File

Outlined here: https://www.secgeek.net/bookfresh-vulnerability/


## PHPInfo.zip

This zip file containes files with filenames for bypassing blacklists and accessing `phpinfo.php`:

- ` make-aio.sh`
- ` phpinfo-aio.tar`
- ` phpinfo-aio.zip`
- `'phpinfo.""gif'`
- `'phpinfo."gif'`
- `"phpinfo.''gif"`
- `"phpinfo.'gif"`
- ` phpinfo.jpg.php`
- ` phpinfo-metadata.gif`
- ` phpinfo-metadata.jpg`
- ` phpinfo.php`
- ` phpinfo.php-1.gif`
- ` phpinfo.php-2.gif`
- ` phpinfo.php3`
- ` phpinfo.php4`
- ` phpinfo.php5`
- ` phpinfo.php7`
- `'phpinfo.php.""gif'`
- `'phpinfo.php."gif'`
- `"phpinfo.php.''gif"`
- `"phpinfo.php.'gif"`
- ` phpinfo.phpt`
- `'phpinfo.php;.txt'`
- ` phpinfo.pht`
- ` phpinfo.phtml`
- ` phpinfo-shortsyntax.php`
- ` phpinfo.txt`

It's impossible to unzip this file on Windows, due to their arbitrary filename restrictions. It's possible to unzip it in WSL though.
