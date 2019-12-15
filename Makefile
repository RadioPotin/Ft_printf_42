# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: evogel <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/11/07 16:47:44 by evogel            #+#    #+#              #
#    Updated: 2019/02/22 10:40:21 by dapinto          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = gcc
COMP = $(CC) -c
DEBUG = $(CC) -g -c

NAME = libftprintf.a
NAMEDEB = libftprintfdeb.a
LIB = $(PATHLIB)libft.a
LIBDEB= $(PATHLIB)libftdeb.a
BIN = ft_printf

DSYM += *.dSYM

MKDIR = mkdir -p
RMRF = rm -rf

INCS += libft.h
INCS += ft_printf.h

#-PATHS && FLAGS-#

PATHINC = includes/
PATHOBJ = ./
PATHOBJDEB = .
PATHSRCS = srcs/
PATHLIB = libft/
vpath %.c srcs/
vpath %.h includes/
WFG = -Wall -Wextra -Werror
IFG = -I$(PATHINC)
CFG = $(WFG) $(IFG)

#-SRCS-#

#FT_PRINTF
SRCS += buff_print.c
SRCS += checkform.c
SRCS += dispatchers.c
SRCS += fieldpad.c
SRCS += ft_printf.c
SRCS += inits_and_freer.c
SRCS += percentmanager.c
SRCS += setformat.c
SRCS += va_argset.c
SRCS += valist_fetch.c
SRCS += vac_module.c
SRCS += vaint_module.c
SRCS += vaf_module.c
SRCS += vastr_module.c
SRCS += vap_module.c

#LIBFT#

#CHECKS#
SRCS += ft_isdigit.c
SRCS += ft_recursive_power.c
SRCS += ft_nchrchck.c

#MEMORY#
SRCS += ft_strdel.c
SRCS += ft_memset.c

#PRINTING#
SRCS += ft_putstr.c

#STRINGS#
SRCS += ft_nonchrseti.c
SRCS += ft_clean_pad.c
SRCS += ft_bzero.c
SRCS += ft_strchr.c
SRCS += ft_strcmp.c
SRCS += ft_strdup.c
SRCS += ft_strjoin.c
SRCS += ft_strlen.c
SRCS += ft_strnew.c
SRCS += ft_strrchr.c
SRCS += ft_strsub.c
SRCS += ft_strichr.c
SRCS += ft_strrev.c
SRCS += ft_strichrset.c
SRCS += ft_strndup.c
SRCS += ft_strchrsetc.c
SRCS += ft_strchrset.c
SRCS += ft_strrchrset.c
SRCS += ft_strcfill.c
SRCS += ft_strsfill.c
SRCS += ft_strtruncto.c
SRCS += ft_strcpy.c

#CONVERSIONS#
SRCS += ft_itoa.c
SRCS += ft_atoi.c
SRCS += ft_base_check_and_strlen.c
SRCS += ft_atoi_base.c
SRCS += ft_itoa_base.c
SRCS += ft_umaxt_itoa.c
SRCS += ft_atoull_base.c
SRCS += ft_atoll_base.c
SRCS += ft_convert_base.c
SRCS += ft_lgdbl_toa.c

#-Printing-#

#No Color#
NO_COLOR    = \033[m
#Black#
BLACK       = \033[0;30m
#Red#
ERROR_COLOR = \033[0;31m
#Green#
OK_COLOR    = \033[0;32m
#Yellow#
WARN_COLOR  = \033[0;33m
#Blue#
COM_COLOR   = \033[0;34m
#Purple#
PURPLE      = \033[0;35m
#Cyan#
OBJ_COLOR   = \033[0;36m
#White#
WHITE       = \033[0;37m

define run_and_test
printf "%b" "$(COM_COLOR)$(COM_STRING) $(OBJ_COLOR)$(@F)$(NO_COLOR)\r"; \
	$(1) 2> $@.log; \
	RESULT=$$?; \
	if [ $$RESULT -ne 0 ]; then \
		printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $@" "$(ERROR_COLOR)$(ERROR_STRING)$(NO_COLOR)\n"   ; \
	elif [ -s $@.log ]; then \
		printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $@" "$(WARN_COLOR)$(WARN_STRING)$(NO_COLOR)\n"   ; \
	else  \
		printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $(@F)" "$(OK_COLOR)$(OK_STRING)$(NO_COLOR)\n"   ; \
	fi; \
	cat $@.log; \
	rm -f $@.log; \
	exit $$RESULT
endef

OK_STRING    = "[SUCCESS]"
ERROR_STRING = "[OH SHIT M8]"
WARN_STRING  = "[Problem ?]"
COM_STRING   = "Compiling"

#-RULES-#

OBJS = $(patsubst %.c, $(PATHOBJ)%.o, $(SRCS))
DEBOBJS = $(patsubst %.c, $(PATHOBJDEB)db%.o, $(SRCS))

all: $(NAME)

debug: $(PATHOBJDEB) $(NAMEDEB)

$(NAME): $(OBJS)
	@ar -rus $@ $^

$(OBJS): $(PATHOBJ)%.o : ./%.c ./includes/ft_printf.h
	@$(call run_and_test, $(COMP) $(CFG) $< -o $@)

$(NAMEDEB): $(DEBOBJS)
	@ar -rus $@ $^

$(DEBOBJS): $(PATHOBJDEB)db%.o : %.c $(INCS)
	$(DEBUG) $(DFG) $(CFG) $(IFG) $< -o $@

clean:
	@$(RMRF) $(OBJS)

cleandeb:
	@$(RMRF) $(NAMEDEB)
	@$(RMRF) $(DSYM)
	@$(RMRF) a.out

fclean: clean cleandeb
	@$(RMRF) $(NAME)
	@$(RMRF) $(BIN)

re: fclean all
