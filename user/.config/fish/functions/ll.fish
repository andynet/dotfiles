function ll --wraps=ls --description 'List contents of directory using long format'
    ls -lhL --group-directories-first $argv
end
