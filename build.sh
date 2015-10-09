mkdir ssh
cp ~/.ssh/id_rsa* ./ssh/
cp ~/.ssh/config ./ssh/

mkdir local
cp ~/.local.gitconfig ./local/

docker build -t docker-go-dev .
