#!/bin/sh

# Retry the build for 30 minutes, every 10 seconds
NUMBER_OF_RETRIES=180
DELAY_BETWEEN_RETRIES=10

for i in $(seq 1 ${NUMBER_OF_RETRIES})
do
    echo "Iteration ${i}"
    ./gradlew lib:test
    result=$?
    if [[ $result -eq 0 ]]
    then
        echo "Result successful"
        break
    else
        echo "Iteration ${i} unsuccessful"
        echo "Wait for ${DELAY_BETWEEN_RETRIES} seconds"
        sleep ${DELAY_BETWEEN_RETRIES}
    fi
done

if [[ $result -ne 0 ]]
then
  echo "All of the trials failed!!!"
  echo "Last status code: ${result}"
fi

exit $result