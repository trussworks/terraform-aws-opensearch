package test

import (
	"fmt"
	"testing"

	awssdk "github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/opensearchservice"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

const awsRegion = "us-west-2"

func NewOpenSearch(t *testing.T, region string) (*opensearchservice.OpenSearchService, error) {
	sess, err := aws.NewAuthenticatedSession(region)
	if err != nil {
		return nil, err
	}
	return opensearchservice.New(sess), nil
}

func TestTerraformAwsOpenSearch(t *testing.T) {
	testName := "terratest-opensearch"
	adminEmail := fmt.Sprintf("%s@test.com", testName)
	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "../", "examples/simple")

	terraformOptions := &terraform.Options{
		TerraformDir: tempTestFolder,
		Vars: map[string]interface{}{
			"domain_name": testName,
			"admin_email": adminEmail,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	openSearch, err := NewOpenSearch(t, awsRegion)
	assert.NoError(t, err)
	openSearchArn := terraform.Output(t, terraformOptions, "opensearch_arn")

	params := &opensearchservice.DescribeDomainInput{
		DomainName: awssdk.String(testName),
	}

	domainDesc, err := openSearch.DescribeDomain(params)
	assert.NoError(t, err)
	assert.Equal(t, openSearchArn, *domainDesc.DomainStatus.ARN)
}