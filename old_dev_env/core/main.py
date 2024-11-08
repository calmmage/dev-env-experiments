import typer

from dev_env.dev_env import (
    CalmmageDevEnv,
    DEFAULT_ROOT_DIR,
    DEFAULT_APP_DATA_DIR,
)


app = typer.Typer()


@app.command()
def create_devenv(
    root_dir: str = DEFAULT_ROOT_DIR, app_data_dir: str = DEFAULT_APP_DATA_DIR
):
    try:
        dev_env = CalmmageDevEnv(
            root_dir=root_dir, app_data_dir=app_data_dir, overwrite=True
        )
        dev_env.setup_shell_profiles()
        typer.echo(f"Development environment created at {root_dir}")
        typer.echo(f"App data directory created at {app_data_dir}")

    except PermissionError:
        typer.echo("Unable to create directories. Check your permissions.")
    except Exception as e:
        typer.echo(f"An error occurred: {str(e)}")


if __name__ == "__main__":
    app()
