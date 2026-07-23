#!/bin/zsh
SIM=A250D68A-3623-4304-8AD8-7889C5034726
BID=com.shenqi.evsepro
shot() {
  local name=$1 link=$2 scrolly=$3
  xcrun simctl terminate $SIM $BID 2>/dev/null
  sleep 1
  export SIMCTL_CHILD_EVSE_QA_HIDE_DEBUG_UI=1
  export SIMCTL_CHILD_EVSE_LAUNCH_DEEPLINK="$link"
  if [[ -n "$scrolly" ]]; then export SIMCTL_CHILD_EVSE_QA_SCROLL_Y=$scrolly; else unset SIMCTL_CHILD_EVSE_QA_SCROLL_Y; fi
  xcrun simctl launch $SIM $BID >/dev/null
  sleep 8
  xcrun simctl io $SIM screenshot "shots/$name.png" >/dev/null 2>&1 && echo "$name done"
}
NAME='Garage%20Charger'
shot energy_flow_en "evsepro://dev/wallbox?state=2&dlb=1&segment=2&name=$NAME"
shot energy_dlb_en  "evsepro://dev/wallbox?state=2&dlb=1&segment=2&name=$NAME" 620
