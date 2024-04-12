# TODO

- Consider running a mock install before performing the actual install to mitigate silly
  errors that preventing install from completing and leaving a half-installed state.
- There is a potential issue/limitation with the MacOS configuration source files that
  relies on hard coded paths relative to the home direcory. When make install is ran,
  the HOMEDIR variable can be defined differently than ~, so hardcoded paths on the
  source files will be different. (It may be easiest to just make this a limiation and
  throw a warning when HOMEDIR is different than HOME). For instance, in `home/.zshrc`,
  `export KRB5_CONFIG=~/.kerberos/krb5.conf` is a hard coded path.
- BUG: If `.zshrc` file already exists, the installer is not able to overwrite the
  file with the correct symbolic link
- Should Linux and MacOS configurations both be in this repo?
- Potential problem with dependencies. The `make-configurator-rules` used to load
  `make-boxerbird`, so when this repo loaded `make-configurator-rules`, there was an
  annoying error about the targets getting reloaded. Need to figure out how to manage
  the dependencies of dependencies. For now, the parent has to load all the child
  dependencies as well.
- Support both FNAL.GOV and fnal.gov in the ssh config
- ssh config should include a local config
- Would be nice if it checked whether it succeeded when creating a new sessions
- Default remote port should be the same as the display
- remote port should have an auto option that allows the next open port to be used (is
  faster to pull them all or repeated calls to the `ss`)
- vnctools should just be it's own seperate program independent of the configuration
  files. A third tool should install these.
        ```bash
        BASE_PORT=1234
        INCREMENT=1

        port=$BASE_PORT

        while [ -n "$(ss -tan4H "sport = $port")" ]; do
          port=$((port+INCREMENT))
        done

        echo "Usable Port: $port"
        ```

        ```bash
        #!/bin/bash

        # Get a list of all listening ports
        listening_ports=$(netstat -tulpn | grep LISTEN)

        # Iterate over the list of listening ports and find the highest port number
        highest_port=0
        for port in $listening_ports; do
          if [[ $port -gt $highest_port ]]; then
            highest_port=$port
          fi
        done

        # Increment the highest port number by 1 to find the next available port
        next_available_port=$((highest_port + 1))

        # Print the next available port to the console
        echo $next_available_port
        ```
