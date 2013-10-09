# cpan2git [![Build Status](https://secure.travis-ci.org/plicease/App-cpan2git.png)](http://travis-ci.org/plicease/App-cpan2git)

Convert cpan distribution from BackPAN to a git repository

# SYNOPSIS

    % cpan2git Foo::Bar

# DESCRIPTION

This script fetches all known revisions of a distribution from CPAN/BackPAN
and creates a git repository with one revision and one tag for each version
of the distribution.

The idea is to create a starting point for a git work flow when adopting a
CPAN module for which you don't have access to the original repository.
It is of course better to import from Subversion or to clone an existing
git repository, but that may not be an option.

# OPTIONS

## \--help | -h

Print out help and exit.

## \--version

Print out version and exit.

# CAVEATS

If the distribution name has changed, this script has no way of knowing it
and so only revisions with the same name will be included.  Possible 
feature would include specifying multiple distribution names in the command
line.

Currently only works on UNIX like operating systems with rm, cp and a tar which
automatically decompresses compressed tars.

There isn't a test aside from making sure [App::cpan2git](http://search.cpan.org/perldoc?App::cpan2git) compiles.

Each commit belongs to the CPAN author who submitted the corresponding release,
therefore `git blame` may not be that useful for the imported portion of
your new repository history.

Patches are welcome.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
