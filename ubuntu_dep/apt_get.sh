xargs -a <(awk \'/^\s*[^#]/\' "./req.txt") -r -- sudo apt-get install
