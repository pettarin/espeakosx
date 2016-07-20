# espeakosx 

A simple Bash script to compile [eSpeak](http://espeak.sourceforge.net/) on Mac OS X

* Version: 1.0.2
* Date: 2016-07-20
* Developer: [Alberto Pettarin](http://www.albertopettarin.it/) ([contact](http://www.albertopettarin.it/contact.html))
* License: the MIT License (MIT), see LICENSE.md


## Important Notes

**2016-07-20**: now if you `brew install espeak` you will get eSpeak and libespeak, as patched by Daniel Bair.
See [this merged PR on Homebrew](https://github.com/Homebrew/homebrew-core/pull/2726).
Please note that it uses the `ASYNC` define, instead of the patches in this repository, which seem to be unstable.
In general, a more robust `sem_timedwait()` replacement is needed.

**2016-07-06**: [Daniel Bair](https://github.com/danielbair) used the patches in this repository to create a brew formula to easily install eSpeak on OS X,
see [issue #2](https://github.com/pettarin/espeakosx/issues/2) for details.

**2016-05-12**: [Jacobo Tarragón](https://github.com/jminuscula) extended the patch to work with OS X 10.10 and 10.11.

**2016-01-02**: eSpeak is transitioning to [eSpeak NG](https://github.com/espeak-ng/espeak-ng),
which should solve the compilation issues in OS X, making this project (espeakosx) obsolete.


## Usage

1. Clone this repo:

    ```bash
    $ git clone https://github.com/pettarin/espeakosx.git
    $ cd espeakosx
    ```

2. Download `pa_stable_v19_20140130.tgz` from
   [PortAudio](http://www.portaudio.com/archives/pa_stable_v19_20140130.tgz)
   into the `espeakosx` directory.

3. Download `espeak-1.48.04-source.zip` from
   [SourceForge](http://sourceforge.net/projects/espeak/files/espeak/espeak-1.48/espeak-1.48.04-source.zip)
   into the `espeakosx` directory.
   (SourceForge uses mirrors and expire parameters,
   so I cannot download the source ZIP
   directly in the `compile.sh` script.)

3. Run the script, providing the PortAudio source TGZ file as the first argument,
   and the eSpeak source ZIP file as the second argument:

    ```bash
    $ bash compile.sh pa_stable_v19_20140130.tgz espeak-1.48.04-source.zip
    ```

4. The compiled eSpeak files will be located in `/tmp/espeakosx/espeak-1.48.04-source/src/`.

5. (OPTIONAL) If you installed `espeak` via `brew` (i.e., `brew install espeak`),
   you might want symlink the `espeak-data` directory:

    ```bash
    $ sudo ln -s /usr/local/share/espeak-data /usr/share/espeak-data
    ```


## License

**espeakosx** is released under the MIT License.


