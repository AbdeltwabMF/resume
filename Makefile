TARGET = Abdeltwab_Fakhry_Resume
COMMIT_DATE := $(shell git log -1 --format=%cd --date=format:'%B %d, %Y')

# ANSI colors for output
RED    := \033[0;31m
GREEN  := \033[0;32m
YELLOW := \033[0;33m
PURPLE := \033[0;35m
WHITE  := \033[0;37m
NC     := \033[0m

all:
	@printf "%b" "$(YELLOW)Building $(TARGET)...\n$(NC)"
	latexmk -pdf -output-directory=./ $(TARGET).tex
	@printf "%b" "$(YELLOW)Refreshing $(TARGET)...\n$(NC)"
	latexmk -pdf -output-directory=./ $(TARGET).tex
	@printf "%b" "$(YELLOW)Generating preview...\n$(NC)"
	pdftoppm -r 300 -png -singlefile $(TARGET).pdf assets/preview
	@printf "%b" "$(YELLOW)Updating the date in index.html...\n$(NC)"
	sed -i "s/Last updated on [^<]*/Last updated on ${COMMIT_DATE}/" index.html
	@printf "%b" "$(GREEN)Done.\n$(NC)"

clean:
	@printf "%b" "$(WHITE)Cleaning...\n$(NC)"
	latexmk -c -output-directory=./ $(TARGET).tex
	rm -f $(TARGET).synctex.gz
	@printf "%b" "$(PURPLE)Cleaning done.$(NC)\n"

.PHONY: all clean
