package v1alpha

import "gopkg.in/yaml.v2"

// UnmarshalBinary interface implementation
func (m *ToolchainPlatformInfo) UnmarshalBinaryFromYAML(b []byte) error {
	var res ToolchainPlatformInfo
	if err := yaml.Unmarshal(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}
