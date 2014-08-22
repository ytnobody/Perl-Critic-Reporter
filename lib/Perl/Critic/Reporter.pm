package Perl::Critic::Reporter;
use 5.008001;
use strict;
use warnings;

use parent 'Exporter';
use Term::ANSIColor;

our $VERSION = "0.01";
our @EXPORT = qw/report_critic/;

sub report_critic {
    my ($violations) = @_;

    if (my $count = scalar(@{$violations})) {
        printf colored("%s violations found\n" => 'red') => $count;

        my $filename = '';
        for my $violation (sort {$a->filename cmp $b->filename} sort {$a->line_number <=> $b->line_number} @{$violations}) {

            if ($filename ne $violation->filename) {
                $filename = $violation->filename;
                my $co_count = scalar(grep {$_->filename eq $filename} @{$violations});
                printf colored("## %s " => 'magenta') => $filename;
                printf colored("(%s violations)\n" => 'blue') => $co_count;
            }

            printf "  * [line %s] %s " => $violation->line_number, $violation->description || 'a something violation found';
            printf colored("(%s)" => 'yellow') => $violation->policy;
            print "\n";
        }

        return 1;
    }
    else {
        printf colored("Yay! no violations found!" => 'cyan')."\n";
        return 0;
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Perl::Critic::Reporter - Output report from violations value of Perl::Critic

=head1 SYNOPSIS

    use Perl::Critic
    use Perl::Critic::Reporter;
    
    my $critic = Perl::Critic->new;
    my @violations = $critic->critique('path/to/script.pl');
    push @violations, $critic->critique('path/to/other/script.pl');
    report_critic([@violations]);

=head1 DESCRIPTION

Perl::Critic::Reporter is a report formatter for violation value of Perl::Critic.

=head1 EXAMPLE IMAGE

=begin html

<img src="http://i.gyazo.com/7511c0b9addeb1c27f93f90f534e6daf.png">

=end html

=head1 EXPORT

=head2 report_critic([@violations])

Print a report about violations that is result of analysing by Perl::Critic.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

