#!/usr/bin/perl
# ------------------------------------------------
# Author: Ryo Nakagami
# Revised: 2024-07-30
# Description:
#   the command return commit-size, commit-id, filecount, commit-date
# Usage: 
#   if you want the comit list each of whose size is over 3MB
#       git_commit_size_check -unit MB -lowersize 3 -days 10 
# ------------------------------------------------
# error handling
use strict;
use warnings;
use Getopt::Long;

# Declare variables
my ($unit, $threshold, $date_param);
my $output     = "";
my $date       = (`date +%Y-%m-%d -d "365 day ago"`);
my $scale_unit = 1;


# Function to print usage information
sub print_usage {
    print << "END";
Usage: git_commit_size_check [options]
Options:
    -u|--unit <unit>        Unit of size (B, KB, MB, GB)
    -l|--lowersize <size>   Lower size threshold
    -d|--days <days>        Number of days to look back
    -h|--help               Show this help message
END
    exit;
}

# Function to get commit size
sub get_commit_size {
    my ($sha) = @_;
    my $tot = 0;
    foreach my $blob (`git diff-tree -r -c -M -C --no-commit-id $sha`) {
        $blob = (split /\s/, $blob)[3];
        next if $blob eq "0000000000000000000000000000000000000000";   # Deleted
        my $size = `echo $blob | git cat-file --batch-check`;
        $size = (split /\s/, $size)[2];
        $tot += int($size);
    }
    return $tot;
}


# main workflows
GetOptions(
    "u|unit=s"  => \$unit,         # expects a string
    "l|lowersize=s" => \$threshold,    # no value expected, just presence or absence
    "d|days=s"  => \$date_param,    # no value expected, just presence or absence
    "h|help"        => sub { print_usage() }
) or print_usage();

# Validate required parameters
if (!defined $unit || !defined $threshold) {
    print "Error: Missing required parameters.\n";
    print_usage();
}

# Adjust date based on the provided days parameter
if ( defined $date_param ) {
    my $tmp = "$date_param day ago";
    $date = (`date +%Y-%m-%d -d "$tmp"`);
}

# Set scale unit based on the provided unit
if ( $unit eq "KB" ) {
    $scale_unit = 1024;
}
elsif ( $unit eq "MB" ) {
    $scale_unit = 1024**2;
}
elsif ( $unit eq "GB" ) {
    $scale_unit = 1024**3;
}
else {
    $unit = "B";
}
$threshold *= $scale_unit;

# Print header
printf "%-12s %-10s %-12s %-12s",  "commit-size", "commit-id", "file-number", "commit-date\n";

# Process each commit
foreach my $rev (`git rev-list --all --pretty=oneline --after $date`) {
    my $sha;
    ($sha = $rev) =~ s/\s.*$//;
    my $tot = get_commit_size($sha);
    if ($tot > $threshold) {
        $tot = int($tot / $scale_unit);
        my $revn = substr($sha, 0, 8);
        my $file_count = `git show --pretty="format:" --name-only $revn | wc -l`;
        my $commit_time = `git show $revn -s --format=%cd --date=short`;
        chomp($file_count, $commit_time);
        printf "%-12s %-10s %-12s %-12s\n", "${tot}${unit}", $revn, $file_count, $commit_time;
    }
}
