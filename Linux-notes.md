# Notes

```sh 
# Check redirects of a URL in case of ERR_TOO_MANY_REDIRECTS error
# Create a file called as redirects.sh and include inside the following

#!/bin/bash
echo
for domain in $@; do
echo --------------------
echo $domain
echo --------------------
curl -sILk $domain | egrep 'HTTP|Loc' | sed 's/Loc/ -> Loc/g'
echo
done
```

```sh 
# Add permissions to the file
chmod +x redirects.sh

# Execute
./redirects.sh website.com
```

