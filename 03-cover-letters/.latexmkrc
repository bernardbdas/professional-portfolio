$pdf_mode = 5; # Use xelatex
$out_dir = 'builds';
$jobname = 'cover-letter';
$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error %O %S';

# Automatic cleanup of auxiliary files and empty directories after build
END {
    if (!$pvc_mode) {
        # Clean up intermediate files, preserving PDF output
        do_cleanup(2);

        # Remove any empty subdirectories created in $out_dir
        if (-d $out_dir) {
            opendir(my $dh, $out_dir);
            my @entries = readdir($dh);
            closedir($dh);
            foreach my $entry (@entries) {
                next if $entry eq '.' || $entry eq '..';
                my $path = "$out_dir/$entry";
                if (-d $path) {
                    rmdir($path); # rmdir only removes empty directories
                }
            }
        }
    }
}
