use strict;
use warnings;
use File::HomeDir::Test;
use File::HomeDir;
use Test::More tests => 5;
use App::cpan2git;
use Capture::Tiny qw( capture_merged );
use File::chdir;
use URI::file;
use Path::Class qw( file dir );

my $home = dir( File::HomeDir->my_home );

do {
  my $dir = $home->subdir('foo');
  $dir->mkpath(0,0700);
  my $git = Git::Wrapper->new($dir);
  $git->init;
  $git->config( 'user.name'  , 'Test User'        );
  $git->config( 'user.email' , 'test@example.com' );
};

do {
  my $uri = URI::file->new(file(__FILE__)->parent->absolute->stringify);
  
  local $CWD = "$home";
  my $ret;

  my @args = (
    '--backpan_index_url' => "$uri/backpan/backpan-index.txt.gz",
    '--backpan_url'       => "$uri/backpan",
    '--metacpan_url'      => "$uri/api.metacpan.org/",
    'Foo::Bar::Baz', 'Foo::Bar',
  );
  
  my $merged = capture_merged { $ret = App::cpan2git->main(@args) };
  is($ret, 0, "% cpan2git @args");
  note $merged;
};

my $git = Git::Wrapper->new($home->subdir('Foo-Bar-Baz')->stringify);

my @commits = $git->log;

like eval { $commits[0]->message }, qr{^version 0\.04$}, "commits.0.message = version 0.04";
diag $@ if $@;
like eval { $commits[1]->message }, qr{^version 0\.03$}, "commits.1.message = version 0.03";
diag $@ if $@;
like eval { $commits[2]->message }, qr{^version 0\.02$}, "commits.2.message = version 0.02";
diag $@ if $@;
like eval { $commits[3]->message }, qr{^version 0\.01$}, "commits.3.message = version 0.01";
diag $@ if $@;


