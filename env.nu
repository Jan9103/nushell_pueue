export-env {
	# make sure the daemon is running
	if ($env.NU_PACKER_CFG | get -i pueue.daemonize | default true) {
		if (ps | where name == 'pueued' | length) == 0 {
			try { pueued --daemonize } catch { print -e 'unable to start pueued..' }
		}
	}
}
