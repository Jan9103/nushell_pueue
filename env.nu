export-env {
	# make sure the daemon is running
	if (ps | where name == 'pueued' | length) == 0 {
		pueued --daemonize
	}
}
