use strict;

use Test::More;
use Test::Differences;
use Capture::Tiny ':all';

use Perl::Critic;
use Perl::Critic::Reporter;

my $critic = Perl::Critic->new(-severity => 1);

subtest 'violation' => sub {
    my $expect = <<EOS;
\e[31m8 violations found
\e[0m\e[35m## t/data/violation.pl \e[0m\e[34m(8 violations)
\e[0m  * [line 1] Code is not tidy \e[33m(Perl::Critic::Policy::CodeLayout::RequireTidyCode)\e[0m
  * [line 1] Module does not end with "1;" \e[33m(Perl::Critic::Policy::Modules::RequireEndWithOne)\e[0m
  * [line 1] Code not contained in explicit package \e[33m(Perl::Critic::Policy::Modules::RequireExplicitPackage)\e[0m
  * [line 1] No package-scoped "\$VERSION" variable found \e[33m(Perl::Critic::Policy::Modules::RequireVersionVar)\e[0m
  * [line 1] Code before strictures are enabled \e[33m(Perl::Critic::Policy::TestingAndDebugging::RequireUseStrict)\e[0m
  * [line 1] Code before warnings are enabled \e[33m(Perl::Critic::Policy::TestingAndDebugging::RequireUseWarnings)\e[0m
  * [line 1] Mixed high and low-precedence booleans \e[33m(Perl::Critic::Policy::ValuesAndExpressions::ProhibitMixedBooleanOperators)\e[0m
  * [line 1] 3 is not one of the allowed literal values (0, 1, 2). Use the Readonly or Const::Fast module or the "constant" pragma instead \e[33m(Perl::Critic::Policy::ValuesAndExpressions::ProhibitMagicNumbers)\e[0m
EOS

    my @violations = $critic->critique('t/data/violation.pl');
    my $stdout = capture_stdout { report_critic([@violations]) };

    eq_or_diff $stdout, $expect, 'violation report';
};

subtest 'cleanse' => sub {
    my $stdout = capture_stdout { report_critic([]) };
    my $expect = <<EOS;
\e[36mYay! no violations found!\e[0m
EOS
    eq_or_diff $stdout, $expect, 'cleanse';
};

done_testing;
