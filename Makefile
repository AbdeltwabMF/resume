TARGET = abdeltwab_m_fakhry_resume

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
	@printf "%b" "$(GREEN)Done.\n$(NC)"

clean:
	@printf "%b" "$(WHITE)Cleaning...\n$(NC)"
	latexmk -c -output-directory=./ $(TARGET).tex
	rm -f $(TARGET).synctex.gz
	@printf "%b" "$(PURPLE)Cleaning done.$(NC)\n"

.PHONY: all clean
