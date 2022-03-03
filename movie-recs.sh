#!/bin/bash

# run movie-recs notebook from CLI using papermill

# process CLI args using bash getops built-in command to simplify CL calls
# this lets us set non-default values selectively
# based on code from:
# https://www.computerhope.com/unix/bash/getopts.htm
usage() {                                 # Function: Print a help message.
  echo "Usage: $0 [ -l LENGTH ] [ -f FRACTION ] [ -t TAG ] [ -r RESULTSDIR ]" 1>&2 
}
exit_abnormal() {                         # Function: Exit with error.
  usage
  exit 1
}

while getopts ":l:f:t:r:d:" options; do   # Loop: Get the next option;
                                          # use silent error checking;
                                          # options n and t take arguments.
  case "${options}" in                    # 
    l)                                    # If the option is n,
      LENGTH=${OPTARG}                    # set $LEN to specified value.
      ;;
    f)                                    # If the option is t,
      FRACTION=${OPTARG}                  # Set $FRACTION to specified value.
      ;;
    t)                                    # If the option is t,
      TAG=${OPTARG}                       # Set $TAG to specified value.
      ;;
    o)                                    # If the option is t,
      OUTPUTDIR=${OPTARG}                 # Set $OUTPUTDIR to specified value.
      ;;
    d)                                    # If the option is t,
      RATINGS=${OPTARG}                      # Set $RATINGS to specified value.
      ;;
    :)                                    # If expected argument omitted:
      echo "Error: -${OPTARG} requires an argument."
      exit_abnormal                       # Exit abnormally.
      ;;
    *)                                    # If unknown (any other) option:
      exit_abnormal                       # Exit abnormally.
      ;;
  esac
done


# parameters are defined in the environment or overwritten
# positional parameters above to support CLI and batch execution

# create a papermill parameter argument vector to pass to the notebook
if [ "${LENGTH}" != "" ]
then
  PARGS="$PARGS -p challenge_length ${LENGTH}"
fi
if [ "${FRACTION}" != "" ]
then
  PARGS="$PARGS -p trainfraction ${FRACTION}"
fi
if [ "${RATINGS}" != "" ]
then
  PARGS="$PARGS -p movie_ratings ${RATINGS}"
fi

LEN=${LENGTH:-5}
FRAC=${FRACTION:-1.0}
TAG=${TAG:-notag}

outfile=${OUTPUTDIR:-results}/movie-recs_${LEN}_${FRAC}_${TAG}.ipynb

papermill \
     ${PARGS} movie-recs.ipynb \
     $outfile
