vim9script

command -nargs=+ -complete=customlist,ProjectCompleteFn Project g:ProjectFn("<args>")

g:project_languages = {
}

def GetCompletions(args: list<string>): list<string>
	assert_equal("Project", args[0])
	var output = []
	# Language hasnt been decided yet
	if len(args) == 2
		for key in keys(g:project_languages)
			output->add(key)
		endfor
		return output
	elseif len(args) == 3
		for command in keys(g:project_languages[args[1]])
			output->add(command)
		endfor 
		return output
	endif
	return output
enddef

def ProjectCompleteFn(ArgLead: string, CmdLine: string, CursorPos: number): list<string>
	# Get portion of command upto cursor position split by whitespace
	var words = split(CmdLine[0 : (CursorPos - 1)])
	# if cursor is not within an existing argument, add another argument
	if CmdLine[CursorPos - 1] == ' ' 
		add(words, "")
	endif
	# argument number of cursor (-2 to make it 0 indexed)
	const arg_pos = len(words) - 2
	# current argument to be completed
	const cur_arg = words[-1]

	var output = []
	for completion in GetCompletions(words)
		if slice(completion, 0, len(cur_arg)) == cur_arg
			add(output, completion)
		endif
	endfor
	return output
enddef

def g:ProjectFn(args: string)
	var split_args = split(args)
	const Command = g:project_languages[split_args[0]][split_args[1]]
	const command_args = split_args[2 :]

	Command(command_args)
enddef

# C related
if !g:project_languages->has_key('c') 
	def CInit(args: list<string>)
		if !has("win32") 
			echoerr "This script has not been tested on non windows OS's: Aborting"
			return
		endif
		# TODO: If current directory already looks like a project, ask for
		# confirmation
		
		# create src, target, include, and lib directories
		mkdir("./src", "p")
		mkdir("./include", "p")
		mkdir("./target", "p")
		mkdir("./lib", "p")

		# if git is present initialize git repo
		if executable('git')
			execute "silent !git init"
			# add gitignore file
			writefile(
				[
					'./target/*',
				],
				"./gitignore"
			)
		endif

		# create src/main and fill it with a hello world program
		writefile(
			readfile(expand('<script>:h') .. '/snippets/cpp/main.cpp'),
			'./src/main.c'
		)

		# create makefile in root directory and fill it with basic sample make
		var makefile = readfile(expand('<script>:h') .. '/snippets/c/makefile')
		makefile->insert("CC := gcc", 1)
		writefile(
			makefile,
			'./makefile'
		)
	enddef

	g:project_languages['c'] = {
		"init": CInit,
	}
endif

# TODO: CPP Projects
# Should be like C but with different filename and compiler as the only
# difference
if !g:project_languages->has_key('cpp') 
	def CPPInit(args: list<string>)
		if !has("win32") 
			echoerr "This script has not been tested on non windows OS's: Aborting"
			return
		endif
		# TODO: If current directory already looks like a project, ask for
		# confirmation
		
		# create src, target, include, and lib directories
		mkdir("./src", "p")
		mkdir("./include", "p")
		mkdir("./target", "p")
		mkdir("./lib", "p")

		# if git is present initialize git repo
		if executable('git')
			execute "silent !git init"
			# add gitignore file
			writefile(
				[
					'./target/*',
				],
				"./gitignore"
			)
		endif

		# create src/main and fill it with a hello world program
		writefile(
			readfile(expand('<script>:h') .. '/snippets/c/main.c'),
			'./src/main.c'
		)

		# create makefile in root directory and fill it with basic sample make
		var makefile = readfile(expand('<script>:h') .. '/snippets/c/makefile')
		makefile->insert("CC := g++", 1)
		writefile(
			makefile,
			'./makefile'
		)
	enddef

	g:project_languages['cpp'] = {
		"init": CPPInit,
	}
endif

# Rust related
if !g:project_languages->has_key('rust') 
	def RustInit(args: list<string>)
		system("cargo init")
	enddef

	g:project_languages['rust'] = {
		"init": RustInit,
	}
endif 
