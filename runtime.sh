# docker run hello-world
echo "Containier Started."
nginx
cd app
rustc main.rs
./main
sleep 60
echo "Container Stopped."