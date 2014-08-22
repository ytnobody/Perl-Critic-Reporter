# NAME

Perl::Critic::Reporter - Output report from violations value of Perl::Critic

# SYNOPSIS

    use Perl::Critic
    use Perl::Critic::Reporter;
    
    my $critic = Perl::Critic->new;
    my @violations = $critic->critique('path/to/script.pl');
    push @violations, $critic->critique('path/to/other/script.pl');
    report_critic([@violations]);

# DESCRIPTION

Perl::Critic::Reporter is a report formatter for violation value of Perl::Critic.

# EXAMPLE IMAGE

<div>
    <img src="http://i.gyazo.com/7511c0b9addeb1c27f93f90f534e6daf.png">
</div>

# EXPORT

## report\_critic(\[@violations\])

Print a report about violations that is result of analysing by Perl::Critic.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
