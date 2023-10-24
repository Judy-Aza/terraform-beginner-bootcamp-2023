#!/usr/bin/env bash

# Define the alias
custom_alias="alias tf='terraform'"

# Check if the alias already exists in .bash_profile
if grep -q "alias tf='terraform'" ~/.bash_profile; then
    echo "Alias 'tf' already exists in ~/.bash_profile."
else
    # Append the alias to the .bash_profile file
    echo "$custom_alias" >> ~/.bash_profile
    echo "Alias 'tf' added to ~/.bash_profile."
fi
