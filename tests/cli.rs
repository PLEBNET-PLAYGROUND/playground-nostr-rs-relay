#[cfg(test)]
mod tests {
    use gnostr_relay::cli::CLIArgs;

    #[test]
    fn cli_tests() {
        use clap::CommandFactory;
        CLIArgs::command().debug_assert();
    }
}
