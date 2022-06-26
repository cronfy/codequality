<?php

namespace tools\codequality\phpstan\rules;

use PhpParser\Node;
use PHPStan\Analyser\Scope;
use PHPStan\Node\FileNode;
use PHPStan\Rules\Rule;
use PHPStan\Rules\RuleErrorBuilder;

/**
 * @implements Rule<FileNode>
 */
class RequireNamespaceRule implements Rule
{
    public function getNodeType(): string
    {
        return FileNode::class;
    }

    public function processNode(Node $node, Scope $scope): array
    {
        $hasNamespace = false;
        /** @var FileNode $node */
        foreach ($node->getNodes() as $subNode) {
            if ($subNode instanceof Node\Stmt\Namespace_) {
                $hasNamespace = true;
                break;
            }
        }

        if ($hasNamespace) {
            return [];
        }

        return [
            RuleErrorBuilder::message(
                'File does not have namespace declaration.'
            )->build(),
        ];
    }
}
