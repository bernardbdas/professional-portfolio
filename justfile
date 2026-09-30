set shell := ["sh", "-c"]
set windows-shell := ["cmd.exe", "/c"]

clean_builds := if os() == "windows" { "if exist builds rd /s /q builds" } else { "rm -rf builds" }
clean_cover_letters := if os() == "windows" { "for /d /r 03-cover-letters %d in (builds) do @if exist \"%d\" rd /s /q \"%d\"" } else { "find 03-cover-letters -type d -name builds -exec rm -rf {} +" }
build_cover_letters := if os() == "windows" { "for /d %d in (03-cover-letters\\*) do @if exist \"%d\\main.tex\" (cd \"%d\" && latexmk -r ..\\.latexmkrc main.tex && cd ..\\..)" } else { "for dir in 03-cover-letters/*/; do if [ -f \"$dir/main.tex\" ]; then (cd \"$dir\" && latexmk -r ../.latexmkrc main.tex); fi; done" }
clean_role_resumes := if os() == "windows" { "for /d /r 04-role-based-resumes %d in (builds) do @if exist \"%d\" rd /s /q \"%d\"" } else { "find 04-role-based-resumes -type d -name builds -exec rm -rf {} +" }
build_role_resumes := if os() == "windows" { "for /d %d in (04-role-based-resumes\\*) do @if exist \"%d\\main.tex\" (cd \"%d\" && latexmk main.tex && cd ..\\..)" } else { "for dir in 04-role-based-resumes/*/; do if [ -f \"$dir/main.tex\" ]; then (cd \"$dir\" && latexmk main.tex); fi; done" }

# List available commands
default:
	@just --list

# Watch the ATS resume update with continuous preview feature of latexmk
watch-ats:
	@echo Watching ATS resume...
	cd 01-ats-resume && latexmk -pvc main.tex

# Watch the Visual resume update with continuous preview feature of latexmk
watch-visual:
	@echo Watching Visual resume...
	cd 02-visual-resume && latexmk -pvc main.tex

# Build the ATS resume
build-ats:
	@echo Building ATS resume...
	cd 01-ats-resume && latexmk main.tex

# Build the Visual resume
build-visual:
	@echo Building Visual resume...
	cd 02-visual-resume && latexmk main.tex

# Build a specific cover letter using latexmk
# Example: just build-cover-letter letter-1
build-cover-letter letter_dir:
	@echo "Building Cover Letter {{letter_dir}}..."
	cd "03-cover-letters/{{letter_dir}}" && latexmk -r ../.latexmkrc main.tex

# Build all cover letters
build-cover-letters:
	@echo "Building all cover letters..."
	{{build_cover_letters}}

# Build a specific role-based resume dynamically with an optional font
# Example: just build-role-resume 04-ai-engineer
# Example: just build-role-resume 04-ai-engineer inter
build-role-resume role_dir font="":
	@if [ -z "{{font}}" ]; then \
		echo "Building Role-Based Resume {{role_dir}}..."; \
		cd "04-role-based-resumes/{{role_dir}}" && latexmk main.tex; \
	else \
		echo "Building Role-Based Resume {{role_dir}} with {{font}} font..."; \
		cd "04-role-based-resumes/{{role_dir}}" && latexmk {{ '-usepretex="\def\myfontoption{' + font + '}"' }} -jobname=bernard-resume-{{font}} main.tex; \
	fi

# Build a role-based resume with a specific font dynamically
# Example: just build-role-font 04-ai-engineer inter
build-role-font role_dir font:
	@echo "Building Role-Based Resume {{role_dir}} with {{font}} font..."
	cd "04-role-based-resumes/{{role_dir}}" && latexmk {{ '-usepretex="\def\myfontoption{' + font + '}"' }} -jobname=bernard-resume-{{font}} main.tex

# Build a specific role-based resume with all 9 font options
# Example: just build-role-resume-all-fonts 04-ai-engineer
build-role-resume-all-fonts role_dir:
	@echo "Building Role-Based Resume {{role_dir}} with all 9 font options..."
	just build-role-font {{role_dir}} sourcesanspro
	just build-role-font {{role_dir}} officecodeprod
	just build-role-font {{role_dir}} sourceserifpro
	just build-role-font {{role_dir}} prata
	just build-role-font {{role_dir}} marcellus
	just build-role-font {{role_dir}} abrilfatface
	just build-role-font {{role_dir}} merriweather
	just build-role-font {{role_dir}} oxygen
	just build-role-font {{role_dir}} inter

# Build all role-based resumes with an optional font dynamically
# Example: just build-role-resumes
# Example: just build-role-resumes inter
build-role-resumes font="":
	just build-role-resume 01-data-analyst {{font}}
	just build-role-resume 02-data-scientist {{font}}
	just build-role-resume 03-data-engineer {{font}}
	just build-role-resume 04-ai-engineer {{font}}
	just build-role-resume 05-ml-engineer {{font}}
	just build-role-resume 06-mlops-engineer {{font}}

# Build all role-based resumes with all 9 font options
build-role-resumes-all-fonts:
	@echo "Building all role-based resumes with all 9 font options..."
	just build-role-resume-all-fonts 01-data-analyst
	just build-role-resume-all-fonts 02-data-scientist
	just build-role-resume-all-fonts 03-data-engineer
	just build-role-resume-all-fonts 04-ai-engineer
	just build-role-resume-all-fonts 05-ml-engineer
	just build-role-resume-all-fonts 06-mlops-engineer

# Build Visual resume with a specific font dynamically
# Example: just build-visual-font inter
build-visual-font font:
	@echo "Building Visual resume with {{font}} font..."
	cd 02-visual-resume && latexmk {{ '-usepretex="\def\myfontoption{' + font + '}"' }} -jobname=bernard-resume-{{font}} main.tex

# Build Visual resume with all 9 font options
build-visual-all-fonts:
	@echo "Building Visual resumes with all 9 font options..."
	just build-visual-font sourcesanspro
	just build-visual-font officecodeprod
	just build-visual-font sourceserifpro
	just build-visual-font prata
	just build-visual-font marcellus
	just build-visual-font abrilfatface
	just build-visual-font merriweather
	just build-visual-font oxygen
	just build-visual-font inter

# Build ATS resume, Visual resume, all Cover Letters, and all Role-Based Resumes
build: build-ats build-visual build-cover-letters build-role-resumes

# Format a specific file
format-file file:
    @echo "Formatting {{file}}..."
    tex-fmt "{{file}}"

# Format ATS resume .tex and .cls files
format-ats:
    @echo "Formatting ATS resume files..."
    tex-fmt -r 01-ats-resume

# Format Visual resume .tex and .cls files
format-visual:
    @echo "Formatting Visual resume files..."
    tex-fmt -r 02-visual-resume

# Format Role-based resume .tex and .cls files
format-role-resumes:
    @echo "Formatting Role-based resume files..."
    tex-fmt -r 04-role-based-resumes

# Format all files
format-all: format-ats format-visual format-role-resumes

# Clean ATS resume auxiliary files recursively
clean-ats:
	@echo "Cleaning ATS auxiliary files..."
	cd 01-ats-resume && latexmk -C && {{clean_builds}}

# Clean Visual resume auxiliary files recursively
clean-visual:
	@echo "Cleaning Visual auxiliary files..."
	cd 02-visual-resume && latexmk -C && {{clean_builds}}

# Clean a specific cover letter auxiliary files
# Example: just clean-cover-letter apple-mle
clean-cover-letter letter_dir:
	@echo "Cleaning Cover Letter {{letter_dir}} auxiliary files..."
	cd "03-cover-letters/{{letter_dir}}" && latexmk -C -r ../.latexmkrc && {{clean_builds}}

# Clean all cover letters auxiliary files
clean-cover-letters:
	@echo "Cleaning all cover letters auxiliary files..."
	{{clean_cover_letters}}

# Clean a specific role-based resume auxiliary files
# Example: just clean-role-resume 01-data-analyst
clean-role-resume role_dir:
	@echo "Cleaning Role-Based Resume {{role_dir}} auxiliary files..."
	cd "04-role-based-resumes/{{role_dir}}" && latexmk -C && {{clean_builds}}

# Clean all role-based resumes auxiliary files
clean-role-resumes:
	@echo "Cleaning all role-based resumes auxiliary files..."
	{{clean_role_resumes}}

# Clean all auxiliary files
clean: clean-ats clean-visual clean-cover-letters clean-role-resumes
