#!/usr/bin/env zsh

current_cap=$(
	ioreg -n AppleSmartBattery -r -a |
		plutil -extract '0.AppleRawCurrentCapacity' raw -
)
max_cap=$(
	ioreg -n AppleSmartBattery -r -a |
		plutil -extract '0.AppleRawMaxCapacity' raw -
)
bp=$((current_cap*100/max_cap))

if   [[ $bp -eq 100 ]]; then echo -n '\uf240';
elif [[ $bp -gt 75  ]]; then echo -n '\uf241';
elif [[ $bp -gt 50  ]]; then echo -n '\uf242';
elif [[ $bp -gt 25  ]]; then echo -n '#[fg=color001]\uf243';
else echo -n '#[fg=color001]\uf244'; fi
