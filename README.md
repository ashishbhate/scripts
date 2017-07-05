Collection of handy scripts I've written over time.

Some scripts require configuration (API keys etc.). These configuration
variables are near the top of the source files.

## Script List

1. `pb-notify.sh`

    Send a PushBullet notification to all installed devices.
    The `PB_API_KEY` bash variable will need to be set.

    Usage:

    `./pb-notify.sh Title Body`

    `Title`: Notification Title

    `Body`: Notification Body

    Example:

    `wget https://example.com/huge-file.mp4; ./pb-notify.sh "Download done"`


2. `file-watcher.sh`

    Watch a text file for changes and run a command if the given pattern is
    found in the changes.
    Requires the `inotifywait` command. Usually found in the "inotify-tools"
    package in most linux distributions.

    Usage:

    `./file-watcher.sh File-To-Watch Pattern Command-To-Run`

    `File-To-Watch`: File to watch for changes

    `Pattern`: Regex to match in the changes

    `Command-To-Run`: Command to run if Pattern is found in the changes

    The line in the changes in which `Pattern` is found is passed as an
    argument to `Command-To-Run`.

    Example:

    `./file-watcher.sh /srv/www/example.com/logs/access.log resume pb-notify.sh`

    The above command watches the logs for example.com and sends a PushBullet
    notification everytime "resume" is found in the request. The PushBullet
    notification text will include the full request.

    Supposing you host your resume at https://example.com/my_resume.pdf; you'll
    get PushBullet notification everytime someone views your resume.
