#!/usr/bin/env bash

if [ ! $# -ge 1 ]; then
  echo Usage: `basename $0` 'file(s)'
  echo
  exit
fi

scriptdir=`dirname $0`

##HOW TO RUN THIS SCRIPT: you need to follow the script name with the filename of the text you want to parse. Example:
###./stanford_penn_to_conll.sh rawsentences.txt
##The first command parses raw text to PTB style constituency trees; the second takes these trees and converts them to dependencies (typed, collapsed, and with propagated conjunctions; modify the stanford command options to change these parameters) printed in CoNLL format.

java -mx150m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -outputFormat "penn" -outputFormatOptions "CCPropagatedDependencies" $scriptdir/grammar/englishPCFG.ser.gz $* > $1.penn

java -mx150m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.trees.EnglishGrammaticalStructure -treeFile $1.penn -conllx -CCprocessed > $1.conll
