require "./spec_helper"

private def collect_directories
  ary = [] of String
  Terminfo::Searcher.each_std_directories do |dir|
    ary << dir
  end
  ary
end

private def preserve_env
  env_terminfo = ENV["TERMINFO"]?
  env_terminfo_dirs = ENV["TERMINFO_DIRS"]?
  env_home = ENV["HOME"]?

  yield
ensure
  ENV["TERMINFO"] = env_terminfo unless env_terminfo.nil?
  ENV["TERMINFO_DIRS"] = env_terminfo_dirs unless env_terminfo_dirs.nil?
  ENV["HOME"] = env_home unless env_home.nil?
end

describe "Terminfo::Searcher.each_directories" do
  it "gives standard directories when no ENV set" do
    preserve_env do
      ENV["TERMINFO"] = nil
      ENV["TERMINFO_DIRS"] = nil
      ENV["HOME"] = nil

      collect_directories.should eq [
        "/etc/terminfo",
        "/lib/terminfo",
        "/usr/share/terminfo",
        "/boot/system/data/terminfo",
      ]
    end
  end

  context "when TERMINFO_DIRS is set" do
    it "gives given directories" do
      preserve_env do
        ENV["TERMINFO"] = nil
        ENV["TERMINFO_DIRS"] = "dir1:dir2:dir3"


        collect_directories.should eq [
          "dir1",
          "dir2",
          "dir3",
        ]
      end
    end

    it "gives given directories with fallback for empty segment" do
      preserve_env do
        ENV["TERMINFO"] = nil
        ENV["TERMINFO_DIRS"] = "dir1::dir3"

        collect_directories.should eq [
          "dir1",
          "/usr/share/terminfo",
          "dir3",
        ]

        ENV["TERMINFO_DIRS"] = ""

        collect_directories.should eq ["/usr/share/terminfo"]

        ENV["TERMINFO_DIRS"] = "dir1:"

        collect_directories.should eq [
          "dir1",
          "/usr/share/terminfo",
        ]

        ENV["TERMINFO_DIRS"] = "dir1::::::"

        collect_directories.should eq [
          "dir1",
          "/usr/share/terminfo",
        ]
      end
    end
  end

  context "when TERMINFO is set" do
    it "includes TERMINFO dir whenever TERMINFO_DIRS is set or not" do
      preserve_env do
        ENV["HOME"] = nil
        ENV["TERMINFO"] = "my_dir"
        ENV["TERMINFO_DIRS"] = nil

        collect_directories.should eq [
          "my_dir",
          "/etc/terminfo",
          "/lib/terminfo",
          "/usr/share/terminfo",
          "/boot/system/data/terminfo",
        ]

        ENV["TERMINFO_DIRS"] = "dir1:dir2"

        collect_directories.should eq [
          "my_dir",
          "dir1",
          "dir2",
        ]
      end
    end
  end

  context "when HOME is set" do
    it "includes home's standard terminfo dir when standard directories are asked" do
      preserve_env do
        ENV["HOME"] = "home_dir"
        ENV["TERMINFO"] = nil
        ENV["TERMINFO_DIRS"] = nil

        collect_directories.should eq [
          "home_dir/.terminfo",
          "/etc/terminfo",
          "/lib/terminfo",
          "/usr/share/terminfo",
          "/boot/system/data/terminfo",
        ]
      end
    end

    it "doesn't include home's standard terminfo dir when TERMINFO_DIRS is set" do
      preserve_env do
        ENV["HOME"] = "home_dir"
        ENV["TERMINFO"] = nil
        ENV["TERMINFO_DIRS"] = "dir1"

        collect_directories.should eq ["dir1"]
      end
    end
  end
end

pending "Terminfo::Searcher.dbpath_for_term" do
end
