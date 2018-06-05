IMGS=$(docker images | grep licserver | awk '{print $3}')
if [ ${#IMGS[0]} -eq 0 ]; then
  echo "No licserver images to delete"
else
  docker rmi -f ${IMGS}
fi

