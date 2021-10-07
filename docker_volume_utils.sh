# Copies the docker volume using the provided docker image
copy_volume() {
	SRC_VOL_NAME=$1
	SRC_CONTAINER=${2:-alpine:latest}
	DST_VOL_NAME=${SRC_VOL_NAME}_backup
	echo "Copying volume ${SRC_VOL_NAME} using container image ${SRC_CONTAINER} into ${DST_VOL_NAME}"
	docker volume rm ${DST_VOL_NAME}
	docker volume create ${DST_VOL_NAME}
	docker run --rm -v ${DST_VOL_NAME}:/backup -v ${SRC_VOL_NAME}:/src $SRC_CONTAINER bash -c "cp -ar /src/* /backup/"
}

# Restores the volume contents from one volume to another
restore_volume_contents() {
	SRC_VOL_NAME=$1
	DST_VOL_NAME=$2
	SRC_CONTAINER=${3:-alpine:latest}
	echo "Copying volume ${SRC_VOL_NAME} using container image ${SRC_CONTAINER} into ${DST_VOL_NAME}"
	docker volume rm ${DST_VOL_NAME}
	docker volume create ${DST_VOL_NAME}
	docker run --rm -v ${DST_VOL_NAME}:/backup -v ${SRC_VOL_NAME}:/src $SRC_CONTAINER bash -c "cp -ar /src/* /backup/"
}
