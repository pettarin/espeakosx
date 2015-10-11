# espeakosx 

A simple Bash script to compile eSpeak on Mac OS X

* Version: 1.0.0
* Date: 2015-10-11
* Developer: [Alberto Pettarin](http://www.albertopettarin.it/) ([contact](http://www.albertopettarin.it/contact.html))
* License: the MIT License (MIT), see LICENSE.md

## Usage

1. Clone this repo:

    ```bash
    $ git clone https://github.com/pettarin/espeakosx.git
    $ cd espeakosx
    ```

2. Download `espeak-1.48.04-source.zip` from
   [SourceForge](http://sourceforge.net/projects/espeak/files/espeak/espeak-1.48/espeak-1.48.04-source.zip)
   into `espeakosx` directory.
   (SourceForge uses mirrors and expire parameters,
   so I cannot download the source ZIP
   directly in the `compile.sh` script.)

3. Run the script, providing the source ZIP file as the first argument:

    ```bash
    $ bash compile.sh espeak-1.48.04-source.zip
    ```

4. The compiled programs and libraries are located in `/tmp/espeakosx/espeak-1.48.04-source/src/`.

5. (OPTIONAL) If you installed `espeak` via `brew` (i.e., `brew install espeak`),
   you might want to symlink the `espeak-data` directory:

    ```bash
    $ ln -s /usr/local/share/espeak-data /usr/share/espeak-data
    ```


## License

**espeakosx** is released under the MIT License.

[![Analytics](https://ga-beacon.appspot.com/UA-52776738-1/espeakosx)](http://www.albertopettarin.it)
