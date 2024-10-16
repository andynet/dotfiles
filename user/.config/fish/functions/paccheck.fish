function paccheck
    set -l n_all (pacman -Qq | wc -w)
    echo -e "Number of installed packages: $n_all\n"

    set -l exp  (pacman -Qqe)
    set -l n_exp (echo $exp | wc -w)
    set -l tmp1 (pacman -Qqet)
    set -l n_tmp1 (echo $tmp1 | wc -w)
    set -l odeps (diff -y --suppress-common-lines (pacman -Qqett | psub) (pacman -Qqet | psub) | cut -f1 | tr "\n" " ")
    set -l n_odeps (echo $odeps | wc -w)
    set -l edeps (diff -y --suppress-common-lines (pacman -Qqe | psub) (pacman -Qeqtt | psub) | cut -f1 | tr "\n" " ")
    set -l n_edeps (echo $edeps | wc -w)

    echo -e "Packages installed explicitly: $n_exp."
    echo -e "End packages ($n_tmp1):\n\t$tmp1"
    echo -e "Optional dependencies ($n_odeps):\n\t$odeps"
    echo -e "Dependencies ($n_edeps):\n\t$edeps\n"

    set -l orphaned (pacman -Qdqt)
    set -l n_orphaned (echo $orphaned | wc -w)
    set -l optional (pacman -Qqdtt)
    set -l n_optional (echo $optional | wc -w)
    set -l n_deps (pacman -Qqd | wc -w)

    # Packages installed as dependencies. Of those
    # Dependencies
    # Optional dependencies
    # Orphaned packages
    echo -e "Packages installed as dependency: $n_deps"
    echo -e "Optional packages ($n_optional):\n\t$optional"
    echo -e "Orphaned packages ($n_orphaned):\n\t$orphaned"
end
