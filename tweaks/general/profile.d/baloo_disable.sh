if [ $(command -v balooctl) ]; then
	balooctl suspend
	balooctl disable
	balooctl purge
fi
