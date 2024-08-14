# lg_flutter_hackathon

We are taking part in the LG hackathon https://weboshackathon.lge.com/

This project uses Flutter 3.13.9, the purpose of this is that the webOS SDK provided by LG supports this version.
We recommend using asdf for this project https://asdf-vm.com/guide/getting-started.html 


By default, git hooks reside in the ./git/hooks folder. The problem is that this folder would not be part of source control and everyone in team should be using the same hooks.
To change the hooks folder to be .githooks, run:

```sh
git config core.hooksPath .githooks/
```