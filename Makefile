version=$$(awk '/version/ { gsub("\"", ""); print $$3 }' pyproject.toml)
build:
	sudo docker build --tag=mbigras/webapp:latest .
	sudo docker tag mbigras/webapp mbigras/webapp:$(version)
run:
	sudo docker run -it --env=PORT=5000 --publish=5000:5000 mbigras/webapp:$(version)
push:
	sudo docker push mbigras/webapp:latest
	sudo docker push mbigras/webapp:$(version)
