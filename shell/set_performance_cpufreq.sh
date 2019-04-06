#!/bin/sh

CMD_CPUFREQ_INFO=/usr/bin/cpufreq-info
CMD_CPUFREQ_SET=/usr/bin/cpufreq-set

PERF_MODE='performance'

if [ -x ${CMD_CPUFREQ_SET} ]
then
    CPUFREQ_GOV=$($CMD_CPUFREQ_INFO --policy | /usr/bin/awk '{print $NF}')
    if [ "$CPUFREQ_GOV" == "$PERF_MODE" ]
    then
      echo "processor scaling frequency already set to ${PERF_MODE} mode, nothing to do."
      exit 0
    else
      sudo ${CMD_CPUFREQ_SET} --related --governor "${PERF_MODE}"
      echo "processor scaling frequency set to ${PERF_MODE} mode."
      exit 0
    fi
else
    echo "cpufreq-set command not found, not modifying processor scaling frequency."
    exit 2
fi
