#!/usr/bin/perl
# Domino.pl - By Onigumo. 02/06/2003.
# Contact: onigumo@free.fr
#
# This program is released under the GPL, see license file in same directory.
#
# ENJOY!

use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;
use HTTP::Cookies;
use Getopt::Std;


getopts("h:d:l:u:f:n");
#use vars qw( $opt_h $opt_d $opt_l $opt_u $opt_f $opt_s);

print "\n\nDomino Hunter - By Onugimo (c)2003 (onigumo@free.fr)\n\n\n";

if (!$opt_h || ($opt_d && $opt_d !~ /.+\.nsf$/) || ($opt_u && $opt_u !~ /.+\:.+/) || ($opt_d && $opt_f))  {
   print "\n\nUSAGE :\n";
   print "\t$0 <-h Host/IP> [-l logfile] [-d remote NSF file] [-u Username:Password]\n";
   print "\t$0 <-h Host/IP> [-l logfile] [-f NSF files list] [-u Username:Password] [-n (no full scan)]\n\n";
   exit 1;
}

$host = $opt_h;
$database = $opt_d;
$logfile = $opt_l;

if ($opt_f) {
   $files = $opt_f;
}else {
   $files = "Domino_files.txt";
}

$authentication_failure = "error";

$browser = LWP::UserAgent->new;
$browser->agent('Mozilla/4.76 [en] (Win98; U)');
$browser->cookie_jar(HTTP::Cookies->new(file => 'cookies.txt', autosave => 1, ignore_discard => 1));
$browser->timeout(5);

if ($opt_u) {
   $opt_u =~ s/ /%20/g; $opt_u =~ /^(.+)\:(.+)$/;
   $username = $1; $password = $2;
   $login_form = "names.nsf/?Login";

   die "Invalid credentials supplied\n\n$!" if (!Login($browser,"http://$host/$login_form",$username,$password));
   print "--[ Using credentials: $username / $password\n";
}

open (LOGFILE,"> $logfile") if ($logfile);

$commands_docs = "Commands_Documents.txt";
$commands_views = "Commands_Views.txt";
$commands_nsf = "Commands_NSF.txt";

if (!$database) {
    ScanFiles($browser,$host,$files);
}
else {
    ScanSingleFile($browser,$host,$database);
}

my_print("\n--[ Finished.\n\n");

close (LOGFILE) if ($logfile);

sub ScanFiles {
        my($browser,$host,$files) = @_;
        my $retvalue, $output;

        my_print("\n--[ Scanning NSF list: $files...\n\n");

        open (FILE, "$files") or die "\n\nSorry Cant Open $files \n\n$!";

        foreach $cgi (<FILE>) {
                chomp $cgi;
                my_print(" -- Now scanning: [$cgi]\n\n") if (!$opt_n);
                ScanSingleFile($browser,$host,$cgi);
        }

        close(FILE);
}

sub ScanSingleFile {
    my($browser,$host,$database) = @_;
    my $retvalue,$url,$output,@views;

    ($retvalue,$url,$output) = TestDatabase($browser,$host,$database);

    if (!$opt_n && $retvalue) {
        OpenDatabase($browser,$host,$database);
        @views = EnumerateViews($browser,$host,$database); die "Error: no valid view found" if (!@views);
        EnumerateDocs($browser,$host,$database,@views);
        Summary();
    } else {
        if (!$opt_n || ($output !~ /^404/ && $output !~ /^500/)) {
           my_print("$url -> $output\n");
        }
    }
}


sub TestDatabase {
    my($browser,$host,$database) = @_;
    my $retvalue,$output,$content,$raw;

    $url = "http://$host/$database";
    ($output,$content,$raw) = GetUrl($browser,$url);

    $retvalue = ($output =~ /^200/);
    return ($retvalue,$url,$output);
}

sub OpenDatabase {
    my($browser,$host,$database) = @_;
    my @C_MSF, $output, $url, $content, $raw;

    open (F3, "$commands_nsf") or die "\n\nCan't open $commands_nsf \n\n$!";
    @C_NSF = <F3>; chop(@C_NSF); close(F3);

    my_print("\n--[ Trying default NSF commands on $database...\n\n");

    foreach $nsf (@C_NSF) {
        $url = "http://$host/$database$nsf";
        ($output,$content, $raw) = GetUrl($browser,$url);
        Output($url,$output);
    }
}

sub EnumerateViews {
    my($browser,$host,$database) = @_;
    my @C_Views, @Valid_Views, $output, $i, $_url, $url, $content, $raw, $viewid;

    open (F2, "$commands_views") or die "\n\nCan't open $commands_views \n\n$!";
    @C_Views = <F2>; chop(@C_Views); close(F2);

    my_print("\n--[ Scanning available views...\n\n");

    for ($i = 282; $i < 4095; $i += 4) {
        $viewid = sprintf "%03x",$i;
        $url = "http://$host/$database/$viewid";
        ($output,$content,$raw) = GetUrl($browser,$url);
        Output($url,$output);
        if ($output =~ /^200/) {
           push(@Valid_Views,$viewid);
           foreach $command (@C_Views) {
                   $_url = "$url$command&AutoFramed";
                   ($output,$content,$raw) = GetUrl($browser,$_url);
                   Output($_url,$output);
                   if ($content =~ /viewentries/) {
                        ParseViewEntries($content,sprintf("%03x",$i));
                   }
           }
        }
    }

    return @Valid_Views;
}

sub ParseViewEntries {
    my ($content, $vid) = @_;
    my @lines = split(/\n/,$content);

    foreach $line (@lines) {
            if ($line =~ /<viewentry[^>]*unid="([^"]*)"[^>]*noteid="([^"]*)"[^>]*>/) {
                $unid{$1} = $vid;
                $noteid{$2} = $vid;

                my_print("\t+ Document $1 / $2 appears in view $vid\n");
            }
    }
}

sub EnumerateDocs {
    my($browser,$host,$database,@views) = @_;
    my @C_Docs, $output, $i, $url, $content, $raw, $nid, $viewnoteid;

    open (F1, "$commands_docs") or die "\n\nCan't open $commands_docs \n\n$!";
    @C_Docs = <F1>; chop(@C_Docs); close(F1);

    my_print("\n--[ Enumerating documents through valid views...\n\n");

    foreach $viewid (@views) {
        my_print("   Current view = $viewid\n\n");

        for ($i = 2294; $i < 4095; $i += 4) {
           $nid = sprintf "%03x",$i;
           $viewnoteid = $noteid{$nid};
           $url = "http://$host/$database/$viewid/$nid?OpenDocument&AutoFramed";
           ($output,$content,$raw) = GetUrl($browser,$url);
           if ($viewnoteid) {
                if ($view =~ /$viewnoteid$/) {
                   Output("-- $url",$output);
                } else {
                   Output("++ $url",$output);
                }
           } else {
                Output(" ? $url",$output);
                $viewnoteid = $viewid;
           }

           if ($output =~ /^200/) {
              $access{$nid}[hex($viewnoteid)] = 1;
           } else {
              if ($viewid eq $viewnoteid) {
                 $access{$nid}[hex{$viewnoteid}] = -10;
              } else {
                 $access{$nid}[hex{$viewnoteid}] = -1;
              }
           }

           break if ($output =~ /^500/);
        }
        my_print("\n");
    }
}

sub Summary {
        my $i,$docid,$restricted, $hexvalue;
        my_print("\n--[ ACLs summary\n\n");

        foreach $docid (keys %access) {
           $restricted = 0;
           my_print("   doc = $docid> ");

           for ($i = 282; $i < 4095; $i += 4) {
                if ($access{$docid}[$i] == 1) {
                    $hexvalue = sprintf "%03x",$i;
                    my_print("$hexvalue|");
                }
                elsif ($access{$docid}[$i] == -1) {
                    print "   |";
                }
                $restricted = ($access{$docid}[$i] == -10);
           }
           my_print("(restricted on home view)") if ($restricted);
           my_print("\n\n");
        }
}


sub GetUrl {
        my ($browser,$url) = @_;
        my $req = new HTTP::Request("GET" => "$url");
        my $response = $browser->request($req);
        my $content, $file, $shorturl;

        return "Access denied" if ($response->status_line =~ /^200/ && $response->as_string =~ /$authentication_failure/);

        if ($response->status_line =~ /^200/) {
            $file = $url; $file =~ s/.*:\/\/[^\/]+\/([^\?]+).*/\/$1/;
            $shorturl = $file; $shorturl =~ s/^.*\.nsf(\/.*)$/$1/;
            $content = $response->content;
            $content =~ s#"$file[^"]*"#""#g;

            if (!$hash{$content}) {
                $hash{$content} = "$shorturl";
            } else {
                return ($response->status_line." (similar to: ".$hash{$content}.")",$content,$response->as_string);
            }
        }

        return ($response->status_line,$content,$response->as_string);
}

sub Login {
        my ($browser,$url,$username,$password) = @_;
        my $req = new HTTP::Request("POST" => "$url");

        $req->content_type('application/x-www-form-urlencoded');
        $req->content('Username='.$username.'&Password='.$password.'&%%ModDate=0000000000000000');
        my $response = $browser->request($req);

        return ($response->as_string !~ /$authentication_failure/);
}


sub Output {
        my($url,$output) = @_;
        my $text;

        if ($output !~ /^404/ && $output !~ /^500/) {
           $text = "$url -> $output\n";
           my_print($text);
        }
}

sub my_print {
        my($arg) = @_;

        print $arg;
        print LOGFILE $arg if ($logfile);
}
