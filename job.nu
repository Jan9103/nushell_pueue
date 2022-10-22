# based on: https://github.com/nushell/nu_scripts/blob/main/background_task/job.nu


# spawn task to run in the background
#
# please note that the it spawned a fresh nushell to execute the given command
# So it doesn't inherit current scope's variables, custom commands, alias definition, except env variables which value can convert to string.
#
# e.g:
# spawn { echo 3 }
export def spawn [
	command: block   # the command to spawn
] {
	let config_path = $nu.config-path
	let env_path = $nu.env-path
	let source_code = (view-source $command | str trim -l -c '{' | str trim -r -c '}')
	let job_id = (pueue add -p $"nu --config \"($config_path)\" --env-config \"($env_path)\" -c '($source_code)'")  # " <- fix nvim-treesitter syntax highlight
	{job_id: $job_id}
}

# raw-spawn task to run in the background
#
# raw-spawned tasks wont load any configurations, but keep env-vars
export def rspawn [
	command: block  # the command to spawn
] {
	let source_code = (view-source $command | str trim -l -c '{' | str trim -r -c '}')
	let job_id = (pueue add -p $'nu -c "($source_code)"')
	{job_id: $job_id}
}

export def log [id: int] {
	pueue log $id -f --json
	| from json
	| transpose -i info
	| flatten --all
	| flatten --all
	| flatten status
}

# get job running status
export def status [] {
	pueue status --json
	| from json
	| get tasks
	| transpose -i status
	| flatten
	| flatten status
}

# kill specific job
export def kill [id: int] {
	pueue kill $id
}

# clean job log
export def clean [] {
	pueue clean
}

# send stdin to task
export def send [
	id: int
	input: string
] {
	pueue send $id $input
}

# wait for job to finish
export def wait [
	...ids: int
] {
	pueue wait $ids
}
