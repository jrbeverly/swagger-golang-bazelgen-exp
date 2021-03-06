// Code generated by go-swagger; DO NOT EDIT.

package v2alpha

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"context"

	"github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag"
)

// ToolchainPlatformInfo toolchain platform info
//
// swagger:model ToolchainPlatformInfo
type ToolchainPlatformInfo struct {

	// executable
	Executable string `json:"executable,omitempty" yaml:"executable,omitempty"`

	// os
	Os string `json:"os,omitempty" yaml:"os,omitempty"`

	// platform
	Platform string `json:"platform,omitempty" yaml:"platform,omitempty"`

	// prefix
	Prefix string `json:"prefix,omitempty" yaml:"prefix,omitempty"`

	// sha256sum
	Sha256sum string `json:"sha256sum,omitempty" yaml:"sha256sum,omitempty"`

	// url
	URL string `json:"url,omitempty" yaml:"url,omitempty"`
}

// Validate validates this toolchain platform info
func (m *ToolchainPlatformInfo) Validate(formats strfmt.Registry) error {
	return nil
}

// ContextValidate validates this toolchain platform info based on context it is used
func (m *ToolchainPlatformInfo) ContextValidate(ctx context.Context, formats strfmt.Registry) error {
	return nil
}

// MarshalBinary interface implementation
func (m *ToolchainPlatformInfo) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *ToolchainPlatformInfo) UnmarshalBinary(b []byte) error {
	var res ToolchainPlatformInfo
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}
